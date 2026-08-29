import React, { useState } from 'react';
import { ArrowLeft, CheckCircle, XCircle, AlertTriangle, ShieldCheck, ArrowRight, Search } from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';
import { LICENSE_REGISTRY } from '../data/mockData';

export default function CompanyRegistration({ setView, setCompanyUser, primaryLang = 'hi' }) {
  const [licenseNumber, setLicenseNumber] = useState('');
  const [verificationResult, setVerificationResult] = useState(null); // 'success', 'expired', 'not_found'
  const [record, setRecord] = useState(null);

  const handleVerify = async (licToVerify) => {
    const rawLic = licToVerify || licenseNumber;
    const trimmedLicense = rawLic.trim().toUpperCase();

    if (!trimmedLicense) {
      setVerificationResult('not_found');
      setRecord(null);
      return;
    }

    const registryEntry = LICENSE_REGISTRY[trimmedLicense];

    try {
      const response = await fetch(
        `http://localhost:5000/api/verify/license/${encodeURIComponent(trimmedLicense)}`
      );
      const result = await response.json();

      if (response.ok && result.verified) {
        const verifiedRecord = {
          ...result.data,
          licenseNumber: result.data.license_number,
          companyName: result.data.company_name,
          status: String(result.data.license_status || '').trim().toUpperCase()
        };
        setVerificationResult(verifiedRecord.status === 'ACTIVE' ? 'success' : 'expired');
        setRecord(verifiedRecord);
        return;
      }
    } catch (error) {
      console.warn('License API unavailable; using synthetic registry:', error);
    }

    if (registryEntry) {
      const status = String(registryEntry.status || '').trim().toUpperCase();
      setVerificationResult(status === 'ACTIVE' ? 'success' : 'expired');
      setRecord(registryEntry);
    } else {
      setVerificationResult('not_found');
      setRecord(null);
    }
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

          <div className="form-group" style={{ marginBottom: '1.25rem' }}>
            <label className="form-label" htmlFor="license-number-input" style={{ fontSize: '1rem', fontWeight: 700 }}>
              {primaryLang === 'hi' ? 'FSSAI / व्यापार लाइसेंस संख्या' : 'FSSAI / Business License Number'}
            </label>
            <input 
              id="license-number-input"
              type="text" 
              className="form-input" 
              placeholder="Enter FSSAI / Business License Number" 
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

        </div>
      </div>
    </div>
  );
}
