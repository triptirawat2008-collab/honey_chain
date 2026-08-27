import React, { useState } from 'react';
import { ArrowLeft, CheckCircle, XCircle, AlertTriangle, ShieldCheck } from 'lucide-react';

export default function CompanyRegistration({ setView, setCompanyUser }) {
  const [licenseNum, setLicenseNum] = useState('');
  const [verificationResult, setVerificationResult] = useState(null); // 'success', 'expired', 'not_found'
  const [record, setRecord] = useState(null);

 const handleVerify = async () => {
  const trimmedId = licenseNum.trim().toUpperCase();

  if (!trimmedId) {
    setVerificationResult('not_found');
    setRecord(null);
    return;
  }

  try {
    const response = await fetch(
      `http://localhost:5000/api/verify/license/${encodeURIComponent(trimmedId)}`
    );

    const result = await response.json();

    if (!response.ok || !result.verified) {
      setVerificationResult('not_found');
      setRecord(null);
      return;
    }

    // Convert PostgreSQL snake_case fields
    // into the format the existing UI expects.
    const registryEntry = {
      ...result.data,
      licenseNumber: result.data.license_number,
      companyName: result.data.company_name,
      status: result.data.license_status
    };

const status = String(registryEntry.status || '').trim().toUpperCase();

if (status === 'ACTIVE') {
  setVerificationResult('success');
  setRecord({
    ...registryEntry,
    status: 'ACTIVE'
  });
} else {
  setVerificationResult('expired');
  setRecord({
    ...registryEntry,
    status
  });
}
  } catch (error) {
    console.error('License verification error:', error);

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
      <div className="auth-container">
        {/* Back Button */}
        <button 
          className="btn btn-secondary" 
          onClick={() => setView('role-selection')} 
          style={{ marginBottom: "2rem", display: "inline-flex", alignItems: "center" }}
        >
          <ArrowLeft size={16} /> Back to Role Selection
        </button>

        <div className="verification-card">
          <h2 style={{ fontSize: "1.5rem", marginBottom: "0.5rem" }}>Verify Your Company</h2>
          <p style={{ fontSize: "0.9rem", color: "var(--color-text-muted)", marginBottom: "1.5rem" }}>
            Verify your official processing/processor business license to create honey batches.
          </p>

          <div className="form-group">
            <label className="form-label" htmlFor="company-license-input">License Number</label>
            <input 
              id="company-license-input"
              type="text" 
              className="form-input" 
              placeholder="Example: LIC-SYN-00001" 
              value={licenseNum}
              onChange={(e) => setLicenseNum(e.target.value)}
              onKeyDown={(e) => { if (e.key === 'Enter') handleVerify(); }}
            />
          </div>

          <button 
            className="btn btn-green" 
            onClick={handleVerify}
            style={{ width: "100%", marginBottom: "1.5rem" }}
          >
            Verify License
          </button>

          {/* Results Alert states */}
          {verificationResult === 'success' && record && (
            <div>
              <div className="verify-alert verify-success">
                <CheckCircle size={18} />
                <span>✓ License Verified</span>
              </div>
              <div className="verify-results">
                <div className="verify-results-title">Registry Details</div>
                <div className="verify-data-row">
                  <span className="verify-data-label">Company Name:</span>
                  <span className="verify-data-value">{record.companyName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">License Number:</span>
                  <span className="verify-data-value">{record.licenseNumber}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">State:</span>
                  <span className="verify-data-value">{record.state}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">License Status:</span>
                  <span className="verify-data-value">
                    <span className="badge-active">{record.status}</span>
                  </span>
                </div>
              </div>
              <button 
                className="btn btn-primary" 
                onClick={handleContinue}
                style={{ width: "100%", display: "flex", justifyContent: "center", alignItems: "center" }}
              >
                Continue to Company Dashboard
              </button>
            </div>
          )}

          {verificationResult === 'expired' && record && (
            <div>
              <div className="verify-alert verify-warning">
                <AlertTriangle size={18} />
                <span>⚠ Registration is not active ({record.status.toLowerCase()})</span>
              </div>
              <div className="verify-results">
                <div className="verify-results-title">Registry Details</div>
                <div className="verify-data-row">
                  <span className="verify-data-label">Company Name:</span>
                  <span className="verify-data-value">{record.companyName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">License Number:</span>
                  <span className="verify-data-value">{record.licenseNumber}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">State:</span>
                  <span className="verify-data-value">{record.state}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">License Status:</span>
                  <span className="verify-data-value">
                    <span className="badge-expired">{record.status}</span>
                  </span>
                </div>
              </div>
              <p style={{ fontSize: "0.8rem", color: "var(--color-danger)", textAlign: "center" }}>
                Company license records must be in ACTIVE status to access dashboard features.
              </p>
            </div>
          )}

          {verificationResult === 'not_found' && (
            <div className="verify-alert verify-error">
              <XCircle size={18} />
              <span>✕ License ID Not Found</span>
            </div>
          )}

          <div className="disclaimer-box">
            <div style={{ display: "flex", gap: "0.4rem", alignItems: "flex-start" }}>
              <ShieldCheck size={16} style={{ color: "var(--color-primary-dark)", flexShrink: 0, marginTop: "2px" }} />
              <div>
<strong>Verification Notice:</strong> License verification checks are performed against the HoneyChain PostgreSQL verification registry.              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
