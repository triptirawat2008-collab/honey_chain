import React, { useState, useRef, useEffect } from 'react';
import { 
  Hexagon, ArrowRight, ShieldCheck, Search,
  Upload, QrCode, ChevronRight, AlertCircle, Camera
} from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';
import { TRANSLATIONS } from '../utils/langHelper';

export default function LandingPage({ setView, setActiveTraceId, primaryLang = 'hi' }) {
  const [manualBatchId, setManualBatchId] = useState('');
  const [inputError, setInputError] = useState('');
  const [isScanning, setIsScanning] = useState(false);
  const [showQrModal, setShowQrModal] = useState(false);
  const [cameraError, setCameraError] = useState('');
  const [isCameraOpen, setIsCameraOpen] = useState(false);
  const videoRef = useRef(null);
  const cameraStreamRef = useRef(null);
  const cameraScanFrameRef = useRef(null);

  const t = (key) => TRANSLATIONS[key]?.[primaryLang] || TRANSLATIONS[key]?.['en'] || key;

  const stopCameraStream = () => {
    if (cameraScanFrameRef.current) {
      cancelAnimationFrame(cameraScanFrameRef.current);
      cameraScanFrameRef.current = null;
    }

    if (cameraStreamRef.current) {
      cameraStreamRef.current.getTracks().forEach((track) => track.stop());
      cameraStreamRef.current = null;
    }

    if (videoRef.current) {
      videoRef.current.srcObject = null;
    }

    setIsCameraOpen(false);
  };

  const extractBatchIdFromValue = (decodedValue) => {
    const raw = String(decodedValue || '').trim();
    if (!raw) return '';

    try {
      const url = new URL(raw);
      const pathname = url.pathname || '';
      const match = pathname.match(/\/trace\/(.+)$/i);
      if (match?.[1]) return decodeURIComponent(match[1]);
      if (url.searchParams.get('batchId')) return decodeURIComponent(url.searchParams.get('batchId'));
      if (url.searchParams.get('id')) return decodeURIComponent(url.searchParams.get('id'));
      return raw;
    } catch (error) {
      const match = raw.match(/\/trace\/(.+)$/i);
      if (match?.[1]) return decodeURIComponent(match[1]);
      return raw;
    }
  };

  const processQrResult = (decodedValue) => {
    const normalized = extractBatchIdFromValue(decodedValue);
    setIsScanning(true);
    setShowQrModal(false);
    stopCameraStream();

    setTimeout(() => {
      setIsScanning(false);
      if (normalized) {
        setActiveTraceId(normalized);
        setView('consumer-trace');
      } else {
        setInputError('⚠️ Batch ID not found');
      }
    }, 900);
  };

  const handleManualVerify = async (batchToVerify) => {
    const raw = batchToVerify !== undefined ? batchToVerify : manualBatchId;
    const trimmed = (raw || '').trim();

    if (!trimmed) {
      setInputError(t('errorMissingBatch'));
      return;
    }

    setInputError('');

    try {
      const response = await fetch(
        `/api/trace/${encodeURIComponent(trimmed)}`
      );
      const result = await response.json();

      if (!response.ok || !result.verified) {
        setInputError('⚠️ Batch or Harvest ID not found');
        return;
      }

      setActiveTraceId(trimmed);
      setView('consumer-trace');
    } catch (error) {
      console.error('Batch verification error:', error);
      setInputError('⚠️ Could not connect to the verification service.');
    }
  };

  const handleQrUpload = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    processQrResult(file.name);
  };

  const startCameraScan = async () => {
    if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
      setCameraError(primaryLang === 'hi' ? 'कैमरा उपलब्ध नहीं है। कृपया फोटो अपलोड करें।' : 'Camera is not available on this device. Please upload an image instead.');
      return;
    }

    try {
      setCameraError('');
      const stream = await navigator.mediaDevices.getUserMedia({
        video: {
          facingMode: { ideal: 'environment' },
          width: { ideal: 1280 },
          height: { ideal: 720 }
        },
        audio: false
      });

      cameraStreamRef.current = stream;

      if (videoRef.current) {
        videoRef.current.srcObject = stream;
        await videoRef.current.play();
      }

      setIsCameraOpen(true);

      const detectQrFromCamera = async () => {
        if (!showQrModal || !videoRef.current || !cameraStreamRef.current) {
          return;
        }

        const video = videoRef.current;

        if (video.readyState < 2) {
          cameraScanFrameRef.current = requestAnimationFrame(detectQrFromCamera);
          return;
        }

        try {
          if ('BarcodeDetector' in window) {
            const detector = new window.BarcodeDetector({ formats: ['qr_code'] });
            const barcodes = await detector.detect(video);
            const qrValue = barcodes?.[0]?.rawValue;
            if (qrValue) {
              processQrResult(qrValue);
              return;
            }
          }
        } catch (error) {
          // Ignore detection failures and continue scanning until the user closes the modal.
        }

        cameraScanFrameRef.current = requestAnimationFrame(detectQrFromCamera);
      };

      cameraScanFrameRef.current = requestAnimationFrame(detectQrFromCamera);
    } catch (error) {
      setIsCameraOpen(false);
      setCameraError(primaryLang === 'hi' ? 'कैमरा अनुमति अस्वीकृत। कृपया फोटो अपलोड करें या अनुमति दें।' : 'Camera permission was denied or unavailable. Please upload an image instead.');
    }
  };

  useEffect(() => {
    return () => {
      stopCameraStream();
    };
  }, []);

  useEffect(() => {
    if (!showQrModal) {
      stopCameraStream();
      setCameraError('');
    }
  }, [showQrModal]);

  return (
    <div className="app-container">
      {/* Top Navbar */}
      <header className="navbar">
        <div 
          className="logo-container" 
          onClick={() => setView('landing')} 
          style={{ cursor: 'pointer' }}
          role="button"
          tabIndex={0}
          aria-label="HoneyChain Home"
        >
          <span className="logo-icon">
            <Hexagon size={32} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
          </span>
          <div style={{ display: 'flex', flexDirection: 'column' }}>
            <span style={{ fontSize: '1.4rem', fontWeight: 800, color: 'var(--color-text-main)', letterSpacing: '-0.02em', lineHeight: 1.1 }}>
              HoneyChain
            </span>
            <span style={{ fontSize: '0.78rem', color: 'var(--color-primary-dark)', fontWeight: 700 }}>
              {primaryLang === 'hi' ? 'हनीचेन • राष्ट्रीय शहद सत्यापन पोर्टल' : 'HoneyChain • National Honey Portal'}
            </span>
          </div>
        </div>

        <nav>
          <ul className="nav-links">
            <li>
              <button 
                type="button"
                className="btn btn-primary" 
                onClick={() => setView('role-selection')}
                style={{ fontWeight: 800, padding: '0.75rem 1.3rem' }}
              >
                <span>{t('getStartedBtn')}</span>
                <ArrowRight size={18} />
              </button>
            </li>
          </ul>
        </nav>
      </header>

      {/* Hero Section with Primary Consumer Verification */}
      <section className="hero-section">
        <div className="hero-content">
          <h1 className="hero-title" style={{ marginBottom: '0.75rem' }}>
            {primaryLang === 'hi' ? (
              <>
                खेत से बाज़ार तक <br />
                <span style={{ color: 'var(--color-primary-dark)' }}>हर बूँद का सत्यापन, किसान का संरक्षण</span>
              </>
            ) : (
              <>
                Trace Every Drop. <br />
                <span style={{ color: 'var(--color-primary-dark)' }}>Protect Every Beekeeper.</span>
              </>
            )}
          </h1>

          <p className="hero-subtitle" style={{ maxWidth: '680px', margin: '0 auto 2rem auto' }}>
            {t('heroSubtitle')}
          </p>

          {/* PRIMARY CONSUMER VERIFICATION CARD - NO LOGIN REQUIRED */}
          <div className="consumer-verify-card">
            <div className="consumer-verify-card-header">
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
                <span style={{ fontSize: '1.4rem' }}>🍯</span>
                <h2 style={{ fontSize: '1.35rem', fontWeight: 800, margin: 0, color: 'var(--color-text-main)' }}>
                  {t('verifyHoneyTitle')}
                </h2>
              </div>
              <SpeakerButton 
                text={t('verifyTtsIntro')} 
                lang={primaryLang}
                size={18}
                showLabel={true}
              />
            </div>

            <p style={{ fontSize: '0.92rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem', textAlign: 'left', lineHeight: 1.5 }}>
              {t('verifyHoneySubtitle')}
            </p>

            {/* Direct Verification Grid: 1. Manual Batch Input, 2. QR Code Scan Button */}
            <div className="verify-inputs-container">
              {/* Batch Input Form */}
              <div className="verify-batch-form">
                <label 
                  htmlFor="hero-batch-input" 
                  style={{ display: 'block', textAlign: 'left', fontSize: '0.88rem', fontWeight: 700, marginBottom: '0.4rem', color: 'var(--color-text-main)' }}
                >
                  {t('enterBatchLabel')}
                </label>
                <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                  <div style={{ flex: '1 1 240px', position: 'relative' }}>
                    <input 
                      id="hero-batch-input"
                      type="text"
                      className="form-input"
                      placeholder={t('enterBatchPlaceholder')}
                      value={manualBatchId}
                      onChange={(e) => {
                        setManualBatchId(e.target.value);
                        if (inputError) setInputError('');
                      }}
                      onKeyDown={(e) => {
                        if (e.key === 'Enter') handleManualVerify();
                      }}
                      style={{ 
                        height: '52px', 
                        fontSize: '1rem', 
                        fontWeight: 600, 
                        borderColor: inputError ? 'var(--color-danger)' : 'var(--color-border)',
                        width: '100%'
                      }}
                      aria-invalid={!!inputError}
                    />
                  </div>
                  <button 
                    type="button"
                    className="btn btn-primary"
                    onClick={() => handleManualVerify()}
                    style={{ minHeight: '52px', padding: '0 1.5rem', fontSize: '1rem', fontWeight: 800, display: 'inline-flex', alignItems: 'center', gap: '0.4rem', whiteSpace: 'nowrap' }}
                  >
                    <Search size={18} />
                    <span>{t('verifyBatchActionBtn')}</span>
                  </button>
                </div>

                {inputError && (
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--color-danger)', fontSize: '0.85rem', marginTop: '0.5rem', textAlign: 'left' }}>
                    <AlertCircle size={15} />
                    <span>{inputError}</span>
                  </div>
                )}
              </div>

              {/* QR Scan Button */}
              <div className="verify-qr-col">
                <span style={{ display: 'block', textAlign: 'left', fontSize: '0.88rem', fontWeight: 700, marginBottom: '0.4rem', color: 'var(--color-text-main)' }}>
                  {primaryLang === 'hi' ? 'या QR कोड से' : 'Or via QR Code'}
                </span>
                <button 
                  type="button"
                  className="btn btn-outline-green"
                  onClick={() => setShowQrModal(true)}
                  style={{ width: '100%', minHeight: '52px', fontSize: '1rem', fontWeight: 700, borderWidth: '2px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem' }}
                >
                  <QrCode size={20} />
                  <span>{t('scanQrBtn')}</span>
                </button>
              </div>
            </div>

          </div>

        </div>
      </section>

      {/* 3 Simple Benefit Cards */}
      <section className="section-container" id="benefits">
        <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
          <div className="section-eyebrow">
            {primaryLang === 'hi' ? 'उपभोक्ताओं और किसानों के लिए' : 'Designed for Consumers & Farmers'}
          </div>
          <h2 className="section-title">
            {primaryLang === 'hi' ? 'हनीचेन के तीन बड़े फायदे' : 'Three Core Promises of HoneyChain'}
          </h2>
        </div>

        <div className="grid-3">
          {/* Card 1 */}
          <div className="benefit-card-rural">
            <div className="benefit-card-icon" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
              🐝
            </div>
            <div className="benefit-card-content">
              <h3>
                {t('benefit1Title')}
                <span className="sub-label">{primaryLang === 'hi' ? 'Simple Hive Tracking' : 'सरल मधुमक्खी पालन'}</span>
              </h3>
              <p>{t('benefit1Desc')}</p>
            </div>
          </div>

          {/* Card 2 */}
          <div className="benefit-card-rural">
            <div className="benefit-card-icon" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
              🧪
            </div>
            <div className="benefit-card-content">
              <h3>
                {t('benefit2Title')}
                <span className="sub-label">{primaryLang === 'hi' ? 'Lab & Quality Proof' : 'लैब जाँच प्रमाण'}</span>
              </h3>
              <p>{t('benefit2Desc')}</p>
            </div>
          </div>

          {/* Card 3 */}
          <div className="benefit-card-rural">
            <div className="benefit-card-icon" style={{ backgroundColor: '#F3E8FF', color: '#7C3AED' }}>
              🔗
            </div>
            <div className="benefit-card-content">
              <h3>
                {t('benefit3Title')}
                <span className="sub-label">{primaryLang === 'hi' ? 'Trusted QR Certificate' : 'डिजिटल QR कोड'}</span>
              </h3>
              <p>{t('benefit3Desc')}</p>
            </div>
          </div>
        </div>
      </section>

      {/* 6-Step Origin Flow */}
      <section className="section-container" id="how-it-works" style={{ backgroundColor: '#FFFFFF', borderRadius: 'var(--radius-xl)', padding: '3rem 2rem', boxShadow: 'var(--shadow-sm)', border: '1px solid var(--color-border)' }}>
        <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
          <div className="section-eyebrow">
            {primaryLang === 'hi' ? 'सरल 6-चरणीय यात्रा' : '6-Step Origin Flow'}
          </div>
          <h2 className="section-title">
            {primaryLang === 'hi' ? 'हनीचेन कैसे काम करता है?' : 'How HoneyChain Works'}
          </h2>
          <p style={{ color: 'var(--color-text-muted)', fontSize: '1rem', maxWidth: '600px', margin: '0 auto' }}>
            {primaryLang === 'hi' 
              ? 'किसान की पेटी से उपभोक्ता की मेज तक हर कदम पारदर्शी और प्रमाणित है।'
              : 'Every step from the village hive box to the consumer dinner table is verifiable.'}
          </p>
        </div>

        <div className="rural-flow-container">
          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#FEF3C7' }}>🧑‍🌾</div>
            <div className="flow-number">1</div>
            <h4>{primaryLang === 'hi' ? 'किसान (Kisan)' : 'Beekeeper (Kisan)'}</h4>
            <p>{primaryLang === 'hi' ? 'मधुमक्खी पालक किसान' : 'Rural Beekeeper'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#DCFCE7' }}>🪪</div>
            <div className="flow-number">2</div>
            <h4>{primaryLang === 'hi' ? 'सरकारी पहचान' : 'Govt / ID Check'}</h4>
            <p>{primaryLang === 'hi' ? 'मधुक्रांति आईडी सत्यापन' : 'Madhukranti Registry'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#FEF3C7' }}>🍯</div>
            <div className="flow-number">3</div>
            <h4>{primaryLang === 'hi' ? 'शहद निकालाई' : 'Harvest Entry'}</h4>
            <p>{primaryLang === 'hi' ? 'GPS व फूल का प्रकार' : 'GPS & Flora Logging'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#DCFCE7' }}>🧪</div>
            <div className="flow-number">4</div>
            <h4>{primaryLang === 'hi' ? 'लैब जाँच' : 'Lab Verification'}</h4>
            <p>{primaryLang === 'hi' ? 'NABL लैब शुद्धता जाँच' : 'NABL Quality Test'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#F3E8FF' }}>⛓️</div>
            <div className="flow-number">5</div>
            <h4>{primaryLang === 'hi' ? 'डिजिटल प्रमाण' : 'Digital Record'}</h4>
            <p>{primaryLang === 'hi' ? 'सुरक्षित लेजर कोड' : 'Tamper-Evident Record'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          <div className="rural-flow-item highlighted-step">
            <div className="flow-badge-icon" style={{ backgroundColor: '#DCFCE7' }}>📱</div>
            <div className="flow-number">6</div>
            <h4>{primaryLang === 'hi' ? 'ग्राहक QR स्कैन' : 'Consumer Scan'}</h4>
            <p>{primaryLang === 'hi' ? '5 सेकंड में सत्यापन' : 'Instant Verification'}</p>
          </div>
        </div>
      </section>

      {/* QR Scanner Modal (Preserved & Enhanced Existing Modal) */}
      {showQrModal && (
        <div className="modal-overlay" onClick={() => setShowQrModal(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()} style={{ maxWidth: '480px', textAlign: 'center', padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '1rem' }}>
              <div style={{ width: '64px', height: '64px', borderRadius: '50%', backgroundColor: '#DCFCE7', display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'var(--color-secondary-dark)' }}>
                <QrCode size={36} />
              </div>
            </div>
            
            <h3 style={{ fontSize: '1.35rem', fontWeight: 800, marginBottom: '0.5rem', color: 'var(--color-text-main)' }}>
              {t('qrModalTitle')}
            </h3>
            
            <p style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem', lineHeight: 1.5 }}>
              {t('qrModalSubtitle')}
            </p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
              <button 
                type="button"
                className="btn btn-green"
                onClick={startCameraScan}
                style={{ width: '100%', fontSize: '0.92rem', fontWeight: 700, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.4rem' }}
              >
                <Camera size={16} />
                <span>{primaryLang === 'hi' ? '📷 कैमरा खोलें' : '📷 Open Camera'}</span>
              </button>

              {isCameraOpen && (
                <div style={{ width: '100%', borderRadius: 'var(--radius-md)', overflow: 'hidden', border: '1px solid var(--color-border)', backgroundColor: '#111827' }}>
                  <video
                    ref={videoRef}
                    autoPlay
                    playsInline
                    muted
                    style={{ width: '100%', display: 'block', maxHeight: '260px', objectFit: 'cover' }}
                  />
                </div>
              )}

              {cameraError && (
                <div style={{ padding: '0.75rem 0.9rem', borderRadius: 'var(--radius-sm)', border: '1px solid var(--color-danger)', backgroundColor: '#FEF2F2', color: 'var(--color-danger)', fontSize: '0.8rem', textAlign: 'left' }}>
                  {cameraError}
                </div>
              )}

              <div style={{ borderTop: '1px dashed var(--color-border)', paddingTop: '1rem' }}>
                <button 
                  type="button"
                  className="btn btn-secondary" 
                  onClick={() => document.getElementById('qr-file-input')?.click()}
                  style={{ width: '100%', fontSize: '0.92rem', fontWeight: 600, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.4rem' }}
                >
                  <Upload size={16} /> 
                  <span>{t('uploadQrImageBtn')}</span>
                </button>
                <input 
                  id="qr-file-input"
                  type="file" 
                  accept="image/*" 
                  style={{ display: 'none' }} 
                  onChange={handleQrUpload} 
                />
              </div>

              <button 
                type="button"
                className="btn btn-secondary" 
                onClick={() => {
                  stopCameraStream();
                  setShowQrModal(false);
                  setCameraError('');
                }}
                style={{ marginTop: '0.25rem' }}
              >
                {t('closeBtn')}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Scanning Overlay Animation */}
      {isScanning && (
        <div className="modal-overlay">
          <div className="modal-content" style={{ maxWidth: '380px', textAlign: 'center', padding: '2.5rem' }}>
            <div className="flow-circle active pulse-icon" style={{ margin: '0 auto 1.5rem auto', width: '4rem', height: '4rem' }}>
              <QrCode size={28} style={{ color: 'white' }} />
            </div>
            <h3 style={{ fontSize: '1.25rem', fontWeight: 800, marginBottom: '0.5rem' }}>
              {t('scanningText')}
            </h3>
            <p style={{ fontSize: '0.88rem', color: 'var(--color-text-muted)' }}>
              {t('scanningSubtext')}
            </p>
          </div>
        </div>
      )}

      {/* Footer */}
      <footer className="footer-rural">
        <div style={{ maxWidth: '900px', margin: '0 auto', textAlign: 'center' }}>
          <p style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--color-text-main)', marginBottom: '0.5rem' }}>
            🍯 HoneyChain (हनीचेन)
          </p>
        </div>
      </footer>
    </div>
  );
}
