import React, { useState } from 'react';
import { ArrowLeft, CheckCircle, XCircle, AlertTriangle, ShieldCheck, ArrowRight, Building, Search } from 'lucide-react';
import { LICENSE_REGISTRY } from '../data/mockData';
import SpeakerButton from '../components/SpeakerButton';

export default function CompanyRegistration({ setView, setCompanyUser, primaryLang = 'hi' }) {
  const [licenseNumber, setLicenseNumber] = useState('LIC-SYN-00001');
  const [verificationResult, setVerificationResult] = useState(null); // 'success', 'expired', 'not_found'
  const [record, setRecord] = useState(null);

  const handleVerify = (licToVerify) => {
    const rawLic = licToVerify || licenseNumber;
    const trimmedLicense = rawLic.trim().toUpperCase();
    const registryEntry = LICENSE_REGISTRY[trimmedLicense];

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

  const handleQuickFill = (lic) => {
    setLicenseNumber(lic);
    handleVerify(lic);
  };

  const handleContinue = () => {
    if (record && verificationResult === 'success') {
      setCompanyUser(record);
      setView('company-dash');
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
                {primaryLang === 'hi' ? 'FSSAI / कंपनी सत्यापन' : 'Company & License Verification'}
              </h2>
              <SpeakerButton 
                text={primaryLang === 'hi' 
                  ? "कंपनी व एफपीओ सत्यापन। अपनी FSSAI लाइसेंस संख्या दर्ज करें।"
                  : "Company verification. Enter your FSSAI license or business registration number."}
                lang={primaryLang}
                size={20}
              />
            </div>
            <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontSize: '0.8rem' }}>
              FSSAI / MoFPI
            </span>
          </div>

          <p style={{ fontSize: '0.95rem', color: 'var(--color-text-muted)', marginBottom: '1.75rem', lineHeight: 1.5 }}>
            {primaryLang === 'hi'
              ? 'शहद प्रसंस्करण कंपनी या एफपीओ का FSSAI लाइसेंस नंबर सत्यापित करें।'
              : 'Verify commercial food processor license credentials to manage batches and bottling.'}
          </p>

          {/* Quick Demo Test Pills */}
          <div style={{ backgroundColor: '#F9FAFB', padding: '1rem', borderRadius: 'var(--radius-md)', border: '1px solid var(--color-border)', marginBottom: '1.5rem' }}>
            <div style={{ fontSize: '0.82rem', fontWeight: 700, color: 'var(--color-text-muted)', marginBottom: '0.5rem' }}>
              ⚡ {primaryLang === 'hi' ? 'परीक्षण के लिए एक क्लिक में चुनें (1-Click Sample Licenses):' : 'Click a sample license to test:'}
            </div>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('LIC-SYN-00001')}
                style={{ fontSize: '0.82rem', borderColor: 'var(--color-secondary)' }}
              >
                🟢 LIC-SYN-00001 (ABC Honey - Active ✅)
              </button>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('LIC-SYN-00002')}
                style={{ fontSize: '0.82rem' }}
              >
                🟢 LIC-SYN-00002 (Himalayan Organics ✅)
              </button>
              <button 
                type="button"
                className="btn btn-secondary btn-sm"
                onClick={() => handleQuickFill('LIC-SYN-00003')}
                style={{ fontSize: '0.82rem', borderColor: 'var(--color-warning)' }}
              >
                🟡 LIC-SYN-00003 (PureSweet - Expired ⚠️)
              </button>
            </div>
          </div>

          <div className="form-group" style={{ marginBottom: '1.25rem' }}>
            <label className="form-label" htmlFor="license-number-input" style={{ fontSize: '1rem', fontWeight: 700 }}>
              {primaryLang === 'hi' ? 'FSSAI / व्यापार लाइसेंस संख्या' : 'FSSAI / Business License Number'}
            </label>
            <input 
              id="license-number-input"
              type="text" 
              className="form-input" 
              placeholder="Example: LIC-SYN-00001" 
              value={licenseNumber}
              onChange={(e) => setLicenseNumber(e.target.value)}
              onKeyDown={(e) => { if (e.key === 'Enter') handleVerify(); }}
              style={{ height: '56px', fontSize: '1.15rem', paddingLeft: '1rem', fontWeight: 600, letterSpacing: '0.04em' }}
            />
          </div>

          <button 
            type="button"
            className="btn btn-green" 
            onClick={() => handleVerify()}
            style={{ width: '100%', minHeight: '56px', fontSize: '1.1rem', fontWeight: 800, marginBottom: '1.5rem' }}
          >
            <Search size={20} />
            <span>{primaryLang === 'hi' ? 'लाइसेंस सत्यापित करें' : 'Verify License Number'}</span>
          </button>

          {/* Results Alert states */}
          {verificationResult === 'success' && record && (
            <div className="verify-success-box" style={{ animation: 'fadeIn 0.3s ease' }}>
              <div className="verify-alert verify-success" style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.9rem 1.25rem' }}>
                <CheckCircle size={22} style={{ color: 'var(--color-secondary-dark)' }} />
                <div>
                  <strong style={{ fontSize: '1rem' }}>
                    {primaryLang === 'hi' ? '✓ FSSAI लाइसेंस वैध एवं सक्रिय' : '✓ FSSAI License Valid & Active'}
                  </strong>
                </div>
              </div>

              <div className="verify-results" style={{ backgroundColor: '#FDFBF7', border: '1px solid var(--color-border)', borderRadius: 'var(--radius-md)', padding: '1.25rem', marginTop: '1rem', marginBottom: '1.25rem' }}>
                <div className="verify-results-title" style={{ fontSize: '0.85rem', textTransform: 'uppercase', color: 'var(--color-text-light)', fontWeight: 700, marginBottom: '0.75rem' }}>
                  {primaryLang === 'hi' ? 'कंपनी पंजीकरण विवरण' : 'Processor License Details'}
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'कंपनी का नाम:' : 'Company Name:'}</span>
                  <span className="verify-data-value" style={{ fontWeight: 800, fontSize: '1.05rem', color: 'var(--color-text-main)' }}>{record.companyName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'FSSAI नंबर:' : 'FSSAI Number:'}</span>
                  <span className="verify-data-value">{record.fssaiNumber}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'राज्य / अधिकार क्षेत्र:' : 'Jurisdiction State:'}</span>
                  <span className="verify-data-value">{record.state} ({record.district})</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'लाइसेंस स्थिति:' : 'License Status:'}</span>
                  <span className="verify-data-value">
                    <span className="badge-active" style={{ backgroundColor: 'var(--color-success-light)', color: 'var(--color-secondary-dark)', fontWeight: 800 }}>
                      🟢 VALID (मान्य) ✅
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
                <span>{primaryLang === 'hi' ? 'कंपनी डैशबोर्ड पर जाएं' : 'Continue to Company Dashboard'}</span>
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
                    {primaryLang === 'hi' ? '⚠️ लाइसेंस की समय सीमा समाप्त (EXPIRED)' : '⚠️ License Status: EXPIRED'}
                  </strong>
                </div>
              </div>

              <div className="verify-results" style={{ backgroundColor: '#FFFBEB', border: '1px solid #FDE68A', borderRadius: 'var(--radius-md)', padding: '1.25rem', marginTop: '1rem' }}>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'कंपनी:' : 'Company:'}</span>
                  <span className="verify-data-value" style={{ fontWeight: 700 }}>{record.companyName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'वैधता तिथि:' : 'Valid Till:'}</span>
                  <span className="verify-data-value">{record.validTill}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">{primaryLang === 'hi' ? 'स्थिति:' : 'Status:'}</span>
                  <span className="verify-data-value">
                    <span className="badge-expired" style={{ backgroundColor: '#FEF3C7', color: '#D97706', fontWeight: 800 }}>
                      🟡 EXPIRED ⚠️
                    </span>
                  </span>
                </div>
              </div>
            </div>
          )}

          {verificationResult === 'not_found' && (
            <div style={{ marginTop: '1rem', animation: 'fadeIn 0.3s ease' }}>
              <div className="verify-alert verify-error" style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', padding: '0.9rem 1.25rem' }}>
                <XCircle size={22} style={{ color: 'var(--color-danger)' }} />
                <div>
                  <strong style={{ fontSize: '0.95rem' }}>
                    {primaryLang === 'hi' ? '✕ लाइसेंस नंबर रिकॉर्ड में नहीं मिला' : '✕ License Number Not Found'}
                  </strong>
                </div>
              </div>
            </div>
          )}

          {/* Prototype disclaimer */}
          <div className="disclaimer-box" style={{ marginTop: '2rem' }}>
            <div style={{ display: 'flex', gap: '0.5rem', alignItems: 'flex-start' }}>
              <ShieldCheck size={18} style={{ color: 'var(--color-secondary-dark)', flexShrink: 0, marginTop: '2px' }} />
              <div style={{ fontSize: '0.82rem', color: 'var(--color-text-muted)', lineHeight: 1.5 }}>
                <strong>{primaryLang === 'hi' ? 'प्रोटोटाइप सूचना:' : 'Prototype Notice:'}</strong> {primaryLang === 'hi'
                  ? 'यह सत्यापन FSSAI FosCos व MoFPI पोर्टल सिमुलेशन पर आधारित है।'
                  : 'License checks query synthetic regulatory databases representing future FSSAI FosCos integration.'}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
