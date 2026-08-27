import React, { useState } from 'react';
import { ArrowLeft, CheckCircle, XCircle, AlertTriangle, ShieldCheck, ArrowRight, UserCheck, Search } from 'lucide-react';
import { BEEKEEPER_REGISTRY } from '../data/mockData';
import SpeakerButton from '../components/SpeakerButton';

export default function BeekeeperRegistration({ setView, setBeekeeperUser, primaryLang = 'hi' }) {
  const [beekeeperId, setBeekeeperId] = useState('BK-SYN-00001');
  const [verificationResult, setVerificationResult] = useState(null); // 'success', 'expired', 'not_found'
  const [record, setRecord] = useState(null);

  const handleVerify = (idToVerify) => {
    const rawId = idToVerify || beekeeperId;
    const trimmedId = rawId.trim().toUpperCase();
    const registryEntry = BEEKEEPER_REGISTRY[trimmedId];

    if (!registryEntry) {
      setVerificationResult('not_found');
      setRecord(null);
    } else if (registryEntry.status !== 'ACTIVE') {
      setVerificationResult('expired');
      setRecord(registryEntry);
    } else {
      setVerificationResult('success');
      setRecord(registryEntry);
    }
  };

  const handleQuickFill = (id) => {
    setBeekeeperId(id);
    handleVerify(id);
  };

  const handleContinue = () => {
    if (record && verificationResult === 'success') {
      setBeekeeperUser(record);
      setView('beekeeper-dash');
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-container" style={{ maxWidth: '640px' }}>
        {/* Back Button */}
        <button 
          className="btn btn-secondary" 
          onClick={() => setView('role-selection')} 
          style={{ marginBottom: '1.75rem', display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontWeight: 600 }}
        >
          <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'वर्ग चयन पर वापस' : 'Back to Role Selection'}
        </button>

        <div className="verification-card">
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <h2 style={{ fontSize: '1.6rem', fontWeight: 800, margin: 0 }}>
                {primaryLang === 'hi' ? 'किसान सत्यापन' : 'Beekeeper Verification'}
              </h2>
              <SpeakerButton 
                text={primaryLang === 'hi' 
                  ? "किसान सत्यापन। अपनी मधुक्रांति या किसान आईडी दर्ज करें। परीक्षण के लिए नीचे दिए गए हरे बटन पर क्लिक करें।"
                  : "Beekeeper verification. Enter your Madhukranti or Beekeeper ID. For demo, click any sample button below."}
                lang={primaryLang}
                size={20}
              />
            </div>
            <span className="badge-active" style={{ backgroundColor: '#FEF3C7', color: '#D97706', fontSize: '0.8rem' }}>
              मधुक्रांति पोर्टल
            </span>
          </div>

          <p style={{ fontSize: '0.95rem', color: 'var(--color-text-muted)', marginBottom: '1.75rem', lineHeight: 1.5 }}>
            {primaryLang === 'hi'
              ? 'अपनी आधिकारिक मधुक्रांति / किसान आईडी दर्ज करके शहद निकालाई और पेटी प्रबंधन पोर्टल से जुड़ें।'
              : 'Enter your official Madhukranti or National Beekeeper ID to access your hive records.'}
          </p>

          {/* Quick Demo Test Pills */}
          <div style={{ backgroundColor: '#F9FAFB', padding: '1rem', borderRadius: 'var(--radius-md)', border: '1px solid var(--color-border)', marginBottom: '1.5rem' }}>
            <div style={{ fontSize: '0.82rem', fontWeight: 700, color: 'var(--color-text-muted)', marginBottom: '0.5rem' }}>
              ⚡ {primaryLang === 'hi' ? 'परीक्षण के लिए एक क्लिक में चुनें (1-Click Sample IDs):' : 'Click a sample ID to test:'}
            </div>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('BK-SYN-00001')}
                style={{ fontSize: '0.82rem', borderColor: 'var(--color-secondary)' }}
              >
                🟢 BK-SYN-00001 (रवि कुमार - Active ✅)
              </button>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('BK-SYN-00002')}
                style={{ fontSize: '0.82rem' }}
              >
                🟢 BK-SYN-00002 (अमित सिंह - Active ✅)
              </button>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('BK-SYN-00003')}
                style={{ fontSize: '0.82rem', borderColor: 'var(--color-warning)' }}
              >
                🟡 BK-SYN-00003 (नेहा शर्मा - Expired ⚠️)
              </button>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('BK-SYN-99999')}
                style={{ fontSize: '0.82rem', borderColor: 'var(--color-danger)' }}
              >
                🔴 BK-SYN-99999 (Invalid ✕)
              </button>
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '1.25rem' }}>
            <label className="form-label" htmlFor="beekeeper-id-input" style={{ fontSize: '1rem', fontWeight: 700 }}>
              {primaryLang === 'hi' ? 'किसान / मधुक्रांति आईडी (Beekeeper ID)' : 'Beekeeper ID / Madhukranti ID'}
            </label>
            <div style={{ position: 'relative' }}>
              <input 
                id="beekeeper-id-input"
                type="text" 
                className="form-input" 
                placeholder="Example: BK-SYN-00001" 
                value={beekeeperId}
                onChange={(e) => setBeekeeperId(e.target.value)}
                onKeyDown={(e) => { if (e.key === 'Enter') handleVerify(); }}
                style={{ height: '56px', fontSize: '1.15rem', paddingLeft: '1rem', fontWeight: 600, letterSpacing: '0.04em' }}
              />
            </div>
          </div>

          <button 
            type="button"
            className="btn btn-primary" 
            onClick={() => handleVerify()}
            style={{ width: '100%', minHeight: '56px', fontSize: '1.1rem', fontWeight: 800, marginBottom: '1.5rem' }}
          >
            <Search size={20} />
            <span>{primaryLang === 'hi' ? 'पहचान सत्यापित करें' : 'Verify Beekeeper ID'}</span>
          </button>

          {/* Results Alert states - Triple status: Color + Icon + Word */}
          {verificationResult === 'success' && record && (
            <div className="verify-success-box" style={{ animation: 'fadeIn 0.3s ease' }}>
              <div className="verify-alert verify-success" style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.9rem 1.25rem' }}>
                <CheckCircle size={22} style={{ color: 'var(--color-secondary-dark)' }} />
                <div>
                  <strong style={{ fontSize: '1rem' }}>
                    {primaryLang === 'hi' ? '✓ किसान पहचान सत्यापित (Active)' : '✓ Beekeeper ID Verified (Active)'}
                  </strong>
                </div>
              </div>

              <div className="verify-results" style={{ backgroundColor: '#FDFBF7', border: '1px solid var(--color-border)', borderRadius: 'var(--radius-md)', padding: '1.25rem', marginTop: '1rem', marginBottom: '1.25rem' }}>
                <div className="verify-results-title" style={{ fontSize: '0.85rem', textTransform: 'uppercase', color: 'var(--color-text-light)', fontWeight: 700, marginBottom: '0.75rem' }}>
                  {primaryLang === 'hi' ? 'सरकारी मधुक्रांति विवरण' : 'Registry Details'}
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'किसान का नाम:' : 'Registered Name:'}</span>
                  <span className="verify-data-value" style={{ fontWeight: 800, fontSize: '1.05rem', color: 'var(--color-text-main)' }}>{record.registeredName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'संघ / संस्था:' : 'Association:'}</span>
                  <span className="verify-data-value">{record.association || 'UP Beekeeper Association'}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'राज्य / जिला:' : 'State & District:'}</span>
                  <span className="verify-data-value">{record.state} ({record.district})</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'पंजीकरण स्थिति:' : 'Registry Status:'}</span>
                  <span className="verify-data-value">
                    <span className="badge-active" style={{ backgroundColor: 'var(--color-success-light)', color: 'var(--color-secondary-dark)', fontWeight: 800 }}>
                      🟢 ACTIVE (सक्रिय) ✅
                    </span>
                  </span>
                </div>
              </div>

              <button 
                type="button"
                className="btn btn-green" 
                onClick={handleContinue}
                style={{ width: '100%', minHeight: '56px', fontSize: '1.15rem', fontWeight: 800, display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '0.5rem' }}
              >
                <span>{primaryLang === 'hi' ? 'किसान डैशबोर्ड पर जाएं' : 'Continue to Beekeeper Dashboard'}</span>
                <ArrowRight size={20} />
              </button>
            </div>
          )}

          {verificationResult === 'expired' && record && (
            <div style={{ marginTop: '1rem', animation: 'fadeIn 0.3s ease' }}>
              <div className="verify-alert verify-warning" style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.9rem 1.25rem' }}>
                <AlertTriangle size={22} style={{ color: 'var(--color-primary-dark)' }} />
                <div>
                  <strong style={{ fontSize: '0.95rem' }}>
                    {primaryLang === 'hi' ? '⚠️ पंजीकरण की अवधि समाप्त (EXPIRED)' : '⚠️ Registration Status: EXPIRED'}
                  </strong>
                </div>
              </div>

              <div className="verify-results" style={{ backgroundColor: '#FFFBEB', border: '1px solid #FDE68A', borderRadius: 'var(--radius-md)', padding: '1.25rem', marginTop: '1rem' }}>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'नाम:' : 'Name:'}</span>
                  <span className="verify-data-value" style={{ fontWeight: 700 }}>{record.registeredName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'राज्य:' : 'State:'}</span>
                  <span className="verify-data-value">{record.state}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'स्थिति:' : 'Status:'}</span>
                  <span className="verify-data-value">
                    <span className="badge-expired" style={{ backgroundColor: '#FEF3C7', color: '#D97706', fontWeight: 800 }}>
                      🟡 EXPIRED (नवीनीकरण आवश्यक) ⚠️
                    </span>
                  </span>
                </div>
              </div>

              <div style={{ marginTop: '1rem', padding: '0.9rem', backgroundColor: '#FEF2F2', borderRadius: 'var(--radius-sm)', border: '1px solid #FCA5A5', fontSize: '0.85rem', color: 'var(--color-danger)' }}>
                <strong>{primaryLang === 'hi' ? 'सलाह:' : 'Advice:'}</strong> {primaryLang === 'hi' 
                  ? 'कृपया अपनी पहचान नवीनीकृत कराने के लिए अपने नजदीकी कृषि विज्ञान केंद्र (KVK) या FPO से संपर्क करें।' 
                  : 'Please contact your local Krishi Vigyan Kendra (KVK) or FPO to renew your registry.'}
              </div>
            </div>
          )}

          {verificationResult === 'not_found' && (
            <div style={{ marginTop: '1rem', animation: 'fadeIn 0.3s ease' }}>
              <div className="verify-alert verify-error" style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.9rem 1.25rem' }}>
                <XCircle size={22} style={{ color: 'var(--color-danger)' }} />
                <div>
                  <strong style={{ fontSize: '0.95rem' }}>
                    {primaryLang === 'hi' ? '✕ किसान आईडी रिकॉर्ड में नहीं मिली' : '✕ Beekeeper ID Not Found in Registry'}
                  </strong>
                </div>
              </div>
              <p style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)', marginTop: '0.75rem', textAlign: 'center' }}>
                {primaryLang === 'hi'
                  ? 'यह आईडी सिमुलेटेड डेटाबेस में नहीं है। परीक्षण के लिए ऊपर दिए गए "BK-SYN-00001" बटन को दबाएं।'
                  : 'This ID does not exist in the prototype registry. Click the "BK-SYN-00001" button above to test.'}
              </p>
            </div>
          )}

          {/* Prototype disclaimer */}
          <div className="disclaimer-box" style={{ marginTop: '2rem' }}>
            <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'flex-start' }}>
              <ShieldCheck size={18} style={{ color: 'var(--color-primary-dark)', flexShrink: 0, marginTop: '2px' }} />
              <div style={{ fontSize: '0.82rem', color: 'var(--color-text-muted)', lineHeight: 1.5 }}>
                <strong>{primaryLang === 'hi' ? 'प्रोटोटाइप सूचना:' : 'Prototype Notice:'}</strong> {primaryLang === 'hi'
                  ? 'यह पहचान सत्यापन भविष्य में राष्ट्रीय मधुमक्खी बोर्ड (NBB) / मधुक्रांति पोर्टल एपीआई से सीधे जुड़ने के लिए तैयार किया गया है।'
                  : 'Beekeeper identity checks query an in-memory synthetic database simulating future integration with the National Bee Board / Madhukranti registry.'}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
