import React, { useState } from 'react';
import { ArrowLeft, CheckCircle, XCircle, AlertTriangle, ShieldCheck } from 'lucide-react';

export default function BeekeeperRegistration({ setView, setBeekeeperUser }) {
  const [beekeeperId, setBeekeeperId] = useState('');
  const [verificationResult, setVerificationResult] = useState(null); // 'success', 'expired', 'not_found'
  const [record, setRecord] = useState(null);

const handleVerify = async () => {
  const trimmedId = beekeeperId.trim().toUpperCase();

  if (!trimmedId) {
    setVerificationResult('not_found');
    setRecord(null);
    return;
  }

  try {
    const response = await fetch(
      `http://localhost:5000/api/verify/beekeeper/${encodeURIComponent(trimmedId)}`
    );

    const result = await response.json();

    if (!response.ok || !result.verified) {
      setVerificationResult('not_found');
      setRecord(null);
      return;
    }

const registryEntry = {
  ...result.data,
  beekeeperId: result.data.beekeeper_id,
  registeredName: result.data.registered_name
};

if (registryEntry.status !== 'ACTIVE') {
      setVerificationResult('expired');
      setRecord(registryEntry);
    } else {
      setVerificationResult('success');
      setRecord(registryEntry);
    }

  } catch (error) {
    console.error('Beekeeper verification error:', error);

    setVerificationResult('not_found');
    setRecord(null);
  }
};

  const handleContinue = () => {
    if (record && verificationResult === 'success') {
      setBeekeeperUser(record);
      setView('beekeeper-dash');
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
          <h2 style={{ fontSize: "1.5rem", marginBottom: "0.5rem" }}>Verify Your Beekeeper Identity</h2>
          <p style={{ fontSize: "0.9rem", color: "var(--color-text-muted)", marginBottom: "1.5rem" }}>
            Verify your official beekeeping credentials to access the harvest registry and hive logs.
          </p>

          <div className="form-group">
            <label className="form-label" htmlFor="beekeeper-id-input">Beekeeper ID</label>
            <input 
              id="beekeeper-id-input"
              type="text" 
              className="form-input" 
              placeholder="Example: BK-SYN-00001" 
              value={beekeeperId}
              onChange={(e) => setBeekeeperId(e.target.value)}
              onKeyDown={(e) => { if (e.key === 'Enter') handleVerify(); }}
            />
          </div>

          <button 
            className="btn btn-primary" 
            onClick={handleVerify}
            style={{ width: "100%", marginBottom: "1.5rem" }}
          >
            Verify Beekeeper ID
          </button>

          {/* Results Alert states */}
          {verificationResult === 'success' && record && (
            <div>
              <div className="verify-alert verify-success">
                <CheckCircle size={18} />
                <span>✓ Beekeeper ID Verified</span>
              </div>
              <div className="verify-results">
                <div className="verify-results-title">Registry Details</div>
                <div className="verify-data-row">
                  <span className="verify-data-label">Registered Name:</span>
                  <span className="verify-data-value">{record.registeredName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">State Jurisdiction:</span>
                  <span className="verify-data-value">{record.state}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">Registry Status:</span>
                  <span className="verify-data-value">
                    <span className="badge-active">{record.status}</span>
                  </span>
                </div>
              </div>
              <button 
                className="btn btn-green" 
                onClick={handleContinue}
                style={{ width: "100%", display: "flex", justifyContent: "center", alignItems: "center" }}
              >
                Continue to Beekeeper Dashboard
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
                  <span className="verify-data-label">Registered Name:</span>
                  <span className="verify-data-value">{record.registeredName}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">State Jurisdiction:</span>
                  <span className="verify-data-value">{record.state}</span>
                </div>
                <div className="verify-data-row">
                  <span className="verify-data-label">Registry Status:</span>
                  <span className="verify-data-value">
                    <span className={record.status === 'EXPIRED' ? 'badge-expired' : 'badge-suspended'}>
                      {record.status}
                    </span>
                  </span>
                </div>
              </div>
              <p style={{ fontSize: "0.8rem", color: "var(--color-danger)", textAlign: "center" }}>
                Identity records must be in ACTIVE status to access dashboard features.
              </p>
            </div>
          )}

          {verificationResult === 'not_found' && (
            <div className="verify-alert verify-error">
              <XCircle size={18} />
              <span>✕ Beekeeper ID Not Found</span>
            </div>
          )}

          <div className="disclaimer-box">
            <div style={{ display: "flex", gap: "0.4rem", alignItems: "flex-start" }}>
              <ShieldCheck size={16} style={{ color: "var(--color-primary-dark)", flexShrink: 0, marginTop: "2px" }} />
              <div>
<strong>Verification Notice:</strong> Beekeeper identity checks are performed against the HoneyChain PostgreSQL verification registry.              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
