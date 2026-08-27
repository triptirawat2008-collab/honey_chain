import React, { useState } from 'react';
import { 
  Hexagon, ArrowRight, ShieldCheck, ClipboardCheck, Compass, 
  Upload, QrCode, Sparkles, CheckCircle2, ChevronRight, Volume2 
} from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';

export default function LandingPage({ setView, setActiveTraceId, primaryLang = 'hi' }) {
  const [isScanning, setIsScanning] = useState(false);
  const [showQrModal, setShowQrModal] = useState(false);

  const handleQrUpload = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Simulate scanning verification delay
    setIsScanning(true);
    setTimeout(() => {
      setIsScanning(false);
      setActiveTraceId('BT-LIC001-20260825-01');
      setView('consumer-trace');
    }, 1200);
  };

  const handleDirectScanSample = () => {
    setIsScanning(true);
    setTimeout(() => {
      setIsScanning(false);
      setActiveTraceId('BT-LIC001-20260825-01');
      setView('consumer-trace');
    }, 1000);
  };

  return (
    <div className="app-container">
      {/* Header */}
      <header className="navbar">
        <div className="logo-container" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
          <span className="logo-icon">
            <Hexagon size={32} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
          </span>
          <div style={{ display: 'flex', flexDirection: 'column' }}>
            <span style={{ fontSize: '1.4rem', fontWeight: 800, color: 'var(--color-text-main)', letterSpacing: '-0.02em', lineHeight: 1.1 }}>
              HoneyChain
            </span>
            <span style={{ fontSize: '0.78rem', color: 'var(--color-primary-dark)', fontWeight: 700 }}>
              हनीचेन • राष्ट्रीय शहद पोर्टल
            </span>
          </div>
        </div>

        <nav>
          <ul className="nav-links">
            <li>
              <button 
                className="btn btn-outline-green" 
                onClick={() => {
                  setActiveTraceId('BT-LIC001-20260825-01');
                  setView('consumer-trace');
                }}
                style={{ display: 'inline-flex', alignItems: 'center', gap: '0.4rem', fontWeight: 700 }}
              >
                <QrCode size={18} />
                <span>{primaryLang === 'hi' ? 'शहद की जाँच (QR)' : 'Verify Honey (QR)'}</span>
              </button>
            </li>
            <li>
              <button 
                className="btn btn-primary" 
                onClick={() => setView('role-selection')}
                style={{ fontWeight: 800, padding: '0.75rem 1.4rem' }}
              >
                <span>{primaryLang === 'hi' ? 'शुरू करें / लॉगिन' : 'Get Started'}</span>
                <ArrowRight size={18} />
              </button>
            </li>
          </ul>
        </nav>
      </header>

      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-content">
          <div className="hero-badge">
            <ShieldCheck size={18} />
            <span>Smart India Hackathon (SIH) 2026 Prototype • राष्ट्रीय मधुमक्खी बोर्ड मॉडल</span>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.75rem', marginBottom: '0.5rem' }}>
            <h1 className="hero-title">
              {primaryLang === 'hi' ? (
                <>
                  खेत से बाज़ार तक <br />
                  <span style={{ color: 'var(--color-primary-dark)' }}>Trace Every Drop. Protect Every Beekeeper.</span>
                </>
              ) : (
                <>
                  Trace Every Drop. Protect Every Beekeeper. <br />
                  <span style={{ color: 'var(--color-primary-dark)', fontSize: '0.85em' }}>खेत से बाज़ार तक - हर बूँद असली</span>
                </>
              )}
            </h1>
            <SpeakerButton 
              text={primaryLang === 'hi' 
                ? "खेत से बाज़ार तक। हर बूँद असली। भारत का पहला सरल मधुमक्खी पालन और शहद सत्यापन पोर्टल।" 
                : "From farm to market, trace every drop and protect every beekeeper. India's trusted honey traceability platform."} 
              lang={primaryLang}
              size={22}
            />
          </div>

          <p className="hero-subtitle">
            {primaryLang === 'hi'
              ? "भारतीय मधुमक्खी पालक किसानों, एफपीओ और उपभोक्ताओं के लिए भरोसेमंद शहद सत्यापन और सरल पेटी प्रबंधन मंच। बिना किसी कागज़ी झंझट के।"
              : "India's trusted honey traceability & simple hive management platform for rural beekeepers, FPOs, and conscious consumers."}
          </p>

          <div className="hero-actions">
            {/* Primary Action Button - Gold, Massive */}
            <button 
              className="btn btn-primary btn-hero-lg" 
              onClick={() => setView('role-selection')}
              style={{ minHeight: '64px', fontSize: '1.25rem', fontWeight: 800, padding: '1rem 2.25rem', boxShadow: 'var(--shadow-premium)' }}
            >
              <span style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-start', textAlign: 'left', lineHeight: 1.2 }}>
                <span>{primaryLang === 'hi' ? 'शुरू करें / किसान लॉगिन' : 'Get Started / Farmer Login'}</span>
                <span style={{ fontSize: '0.8rem', fontWeight: 500, opacity: 0.9 }}>
                  {primaryLang === 'hi' ? 'Get Started / Login' : 'लॉगिन करें (किसान एवं कंपनी)'}
                </span>
              </span>
              <ArrowRight size={24} style={{ marginLeft: '0.75rem' }} />
            </button>

            {/* Secondary Action Button - Outlined Green */}
            <button 
              className="btn btn-outline-green btn-hero-lg" 
              onClick={() => setShowQrModal(true)}
              style={{ minHeight: '64px', fontSize: '1.15rem', fontWeight: 700, padding: '1rem 1.8rem', borderWidth: '2.5px' }}
            >
              <QrCode size={24} style={{ marginRight: '0.5rem' }} />
              <span style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-start', textAlign: 'left', lineHeight: 1.2 }}>
                <span>{primaryLang === 'hi' ? 'शहद बोतल QR स्कैन करें' : 'Scan / Verify Batch'}</span>
                <span style={{ fontSize: '0.75rem', fontWeight: 500, opacity: 0.85 }}>
                  {primaryLang === 'hi' ? 'Public Consumer Verification' : 'सार्वजनिक उपभोक्ता जाँच'}
                </span>
              </span>
            </button>
          </div>

          {/* Trust line */}
          <div className="trust-pledge-banner">
            <span className="trust-icon">✨</span>
            <strong>{primaryLang === 'hi' ? 'हर बूँद असली — Every drop verified from hive to jar.' : 'Every drop verified from hive to jar — हर बूँद असली।'}</strong>
          </div>
        </div>
      </section>

      {/* 3 Simple Benefit Cards (Icon-First, 1 Short Line) */}
      <section className="section-container" id="benefits">
        <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
          <div className="section-eyebrow">
            {primaryLang === 'hi' ? 'किसानों और उपभोक्ताओं के लिए' : 'Designed for Village & City Alike'}
          </div>
          <h2 className="section-title">
            {primaryLang === 'hi' ? 'हनीचेन के तीन बड़े फायदे' : 'Three Simple Promises of HoneyChain'}
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
                {primaryLang === 'hi' ? 'सरल मधुमक्खी पालन' : 'Simple Hive Tracking'}
                <span className="sub-label">{primaryLang === 'hi' ? 'Simple Hive Tracking' : 'सरल मधुमक्खी पालन'}</span>
              </h3>
              <p>
                {primaryLang === 'hi' 
                  ? 'अपनी पेटियों और जगह बदलने का हिसाब आसानी से रखें, बिना किसी लिखा-पढ़ी के।' 
                  : 'Keep records of your hives and location changes easily with zero paperwork.'}
              </p>
            </div>
          </div>

          {/* Card 2 */}
          <div className="benefit-card-rural">
            <div className="benefit-card-icon" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
              🧪
            </div>
            <div className="benefit-card-content">
              <h3>
                {primaryLang === 'hi' ? 'लैब जाँच प्रमाण' : 'Lab & Quality Proof'}
                <span className="sub-label">{primaryLang === 'hi' ? 'Lab & Quality Proof' : 'लैब जाँच प्रमाण'}</span>
              </h3>
              <p>
                {primaryLang === 'hi' 
                  ? 'सरकारी लैब रिपोर्ट जोड़ें और कंपनियों व खरीदारों से अपनी शहद का बेहतरीन दाम पाएं।' 
                  : 'Store official test reports to get better prices from companies and FPOs.'}
              </p>
            </div>
          </div>

          {/* Card 3 */}
          <div className="benefit-card-rural">
            <div className="benefit-card-icon" style={{ backgroundColor: '#F3E8FF', color: '#7C3AED' }}>
              🔗
            </div>
            <div className="benefit-card-content">
              <h3>
                {primaryLang === 'hi' ? 'डिजिटल QR कोड प्रमाण' : 'Trusted Honey Certificate'}
                <span className="sub-label">{primaryLang === 'hi' ? 'Trusted QR Certificate' : 'डिजिटल QR कोड'}</span>
              </h3>
              <p>
                {primaryLang === 'hi' 
                  ? 'हर डिब्बे के लिए सुरक्षित QR कोड बनाएं ताकि खरीदार आपकी शहद की शुद्धता पर पूरा भरोसा करें।' 
                  : 'Generate tamper-evident QR codes so buyers and consumers trust your honey instantly.'}
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* "How It Works" Visual Step-Flow */}
      <section className="section-container" id="how-it-works" style={{ backgroundColor: '#FFFFFF', borderRadius: 'var(--radius-xl)', padding: '3.5rem 2rem', boxShadow: 'var(--shadow-sm)', border: '1px solid var(--color-border)' }}>
        <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
          <div className="section-eyebrow">
            {primaryLang === 'hi' ? 'सरल 6-चरणीय यात्रा' : '6-Step Origin Flow'}
          </div>
          <h2 className="section-title">
            {primaryLang === 'hi' ? 'हनीचेन कैसे काम करता है?' : 'How HoneyChain Works'}
          </h2>
          <p style={{ color: 'var(--color-text-muted)', fontSize: '1rem', maxWidth: '600px', margin: '0 auto' }}>
            {primaryLang === 'hi' 
              ? 'किसान की पेटी से उपभोक्ता की मेज तक हर कदम डिजिटल और सुरक्षित है।'
              : 'Every step from the village hive box to the consumer dinner table is tamper-evident.'}
          </p>
        </div>

        <div className="rural-flow-container">
          {/* Step 1 */}
          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#FEF3C7' }}>🧑‍🌾</div>
            <div className="flow-number">1</div>
            <h4>{primaryLang === 'hi' ? 'किसान (Kisan)' : 'Beekeeper (Kisan)'}</h4>
            <p>{primaryLang === 'hi' ? 'मधुमक्खी पालक किसान' : 'Rural Beekeeper'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          {/* Step 2 */}
          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#DCFCE7' }}>🪪</div>
            <div className="flow-number">2</div>
            <h4>{primaryLang === 'hi' ? 'सरकारी पहचान' : 'Govt / ID Check'}</h4>
            <p>{primaryLang === 'hi' ? 'मधुक्रांति आईडी सत्यापन' : 'Madhukranti Registry'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          {/* Step 3 */}
          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#FEF3C7' }}>🍯</div>
            <div className="flow-number">3</div>
            <h4>{primaryLang === 'hi' ? 'शहद निकालाई' : 'Harvest Entry'}</h4>
            <p>{primaryLang === 'hi' ? 'GPS व फूल का प्रकार' : 'GPS & Flora Logging'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          {/* Step 4 */}
          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#DCFCE7' }}>🧪</div>
            <div className="flow-number">4</div>
            <h4>{primaryLang === 'hi' ? 'लैब जाँच' : 'Lab Verification'}</h4>
            <p>{primaryLang === 'hi' ? 'NABL लैब शुद्धता जाँच' : 'NABL Purity Test'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          {/* Step 5 */}
          <div className="rural-flow-item">
            <div className="flow-badge-icon" style={{ backgroundColor: '#F3E8FF' }}>⛓️</div>
            <div className="flow-number">5</div>
            <h4>{primaryLang === 'hi' ? 'ब्लॉकचेन रिकॉर्ड' : 'Ledger Hash'}</h4>
            <p>{primaryLang === 'hi' ? 'अपरिवर्तनीय डिजिटल कोड' : 'Tamper-Evident Hash'}</p>
          </div>

          <div className="flow-connector"><ChevronRight size={24} /></div>

          {/* Step 6 */}
          <div className="rural-flow-item highlighted-step">
            <div className="flow-badge-icon" style={{ backgroundColor: '#DCFCE7' }}>📱</div>
            <div className="flow-number">6</div>
            <h4>{primaryLang === 'hi' ? 'ग्राहक QR स्कैन' : 'Consumer Scan'}</h4>
            <p>{primaryLang === 'hi' ? '5 सेकंड में शुद्धता प्रमाण' : 'Instant 5s Purity Proof'}</p>
          </div>
        </div>
      </section>

      {/* Demo Quick Scanner Modal */}
      {showQrModal && (
        <div className="modal-overlay">
          <div className="modal-content" style={{ maxWidth: '460px', textAlign: 'center', padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '1rem' }}>
              <div style={{ width: '64px', height: '64px', borderRadius: '50%', backgroundColor: '#DCFCE7', display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'var(--color-secondary-dark)' }}>
                <QrCode size={36} />
              </div>
            </div>
            <h3 style={{ fontSize: '1.35rem', marginBottom: '0.5rem' }}>
              {primaryLang === 'hi' ? 'शहद जार QR कोड स्कैन करें' : 'Scan Honey Jar QR Code'}
            </h3>
            <p style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', marginBottom: '1.75rem' }}>
              {primaryLang === 'hi'
                ? 'स्मार्ट इंडिया हैकाथॉन डेमो: किसी भी नमूना बैच को तुरंत सत्यापित करने के लिए नीचे क्लिक करें।'
                : 'SIH Prototype Demo: Click below to simulate scanning a jar of certified Indian honey.'}
            </p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
              <button 
                className="btn btn-green"
                onClick={handleDirectScanSample}
                style={{ padding: '0.9rem', fontSize: '1rem', fontWeight: 700 }}
              >
                ✨ {primaryLang === 'hi' ? 'नमूना बैच BT-LIC001 जाँचें (1-Click)' : 'Scan Sample Batch (BT-LIC001)'}
              </button>

              <div style={{ borderTop: '1px dashed var(--color-border)', paddingTop: '1rem' }}>
                <button 
                  className="btn btn-secondary" 
                  onClick={() => document.getElementById('qr-file-input')?.click()}
                  style={{ width: '100%', fontSize: '0.9rem' }}
                >
                  <Upload size={16} /> {primaryLang === 'hi' ? 'QR कोड फोटो अपलोड करें' : 'Upload QR Image'}
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
                className="btn btn-secondary" 
                onClick={() => setShowQrModal(false)}
                style={{ marginTop: '0.5rem' }}
              >
                {primaryLang === 'hi' ? 'बंद करें' : 'Close'}
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
            <h3 style={{ fontSize: '1.25rem', marginBottom: '0.5rem' }}>
              {primaryLang === 'hi' ? 'QR कोड स्कैन हो रहा है...' : 'Scanning QR Code...'}
            </h3>
            <p style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>
              {primaryLang === 'hi' 
                ? 'ब्लॉकचेन लेजर से शहद की शुद्धता व किसान रिकॉर्ड का मिलान किया जा रहा है...'
                : 'Verifying batch cryptographic hash against HoneyChain registry...'}
            </p>
          </div>
        </div>
      )}

      {/* Footer with SIH Prototype Disclaimer */}
      <footer className="footer-rural">
        <div style={{ maxWidth: '900px', margin: '0 auto', textAlign: 'center' }}>
          <p style={{ fontSize: '0.95rem', fontWeight: 600, color: 'var(--color-text-main)', marginBottom: '0.5rem' }}>
            🍯 HoneyChain (हनीचेन) — Smart India Hackathon (SIH) 2026 Prototype
          </p>
          <p style={{ fontSize: '0.82rem', color: 'var(--color-text-muted)', lineHeight: 1.6 }}>
            {primaryLang === 'hi'
              ? 'प्रोटोटाइप सूचना: यह एक सिमुलेटेड फ्रंटएंड डेमो है जो भविष्य में राष्ट्रीय मधुमक्खी बोर्ड (NBB), मधुक्रांति पोर्टल और FSSAI के साथ डिजिटल एकीकरण को दर्शाता है।'
              : 'SIH Prototype Notice: All identity registries and blockchain ledger records utilize synthetic test data simulating future Madhukranti & National Bee Board integration.'}
          </p>
        </div>
      </footer>
    </div>
  );
}
