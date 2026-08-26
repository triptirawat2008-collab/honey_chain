import React, { useState } from 'react';
import { 
  ShieldCheck, AlertTriangle, Hexagon, Building, User, 
  Clipboard, FileText, ChevronDown, ChevronUp, ArrowLeft
} from 'lucide-react';

export default function ConsumerTraceability({ 
  traceId, setView, harvests, batches 
}) {
  const [showBlockchainDetails, setShowBlockchainDetails] = useState(false);
  const [showReportModal, setShowReportModal] = useState(false);
  const [isTampered, setIsTampered] = useState(false);

  const isBatch = traceId ? traceId.startsWith('BT-') : false;
  const isHarvest = traceId ? traceId.startsWith('HB-') : false;

  let activeRecord = null;
  let sourceHarvestsList = [];

  if (isBatch) {
    activeRecord = batches.find(b => b.batchId === traceId);
    if (activeRecord) {
      sourceHarvestsList = harvests.filter(h => activeRecord.sourceHarvestIds.includes(h.harvestId));
    }
  } else if (isHarvest) {
    activeRecord = harvests.find(h => h.harvestId === traceId);
    if (activeRecord) {
      sourceHarvestsList = [activeRecord];
    }
  }

  // Handle case where traceId is invalid or record is not found
  if (!activeRecord) {
    return (
      <div className="consumer-layout">
        <header className="consumer-header">
          <div className="logo-container" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
            <span className="logo-icon">
              <Hexagon size={28} fill="#F5A623" color="#D97706" strokeWidth={2} />
            </span>
            <span>HoneyChain</span>
          </div>
          <button className="btn btn-secondary btn-sm" onClick={() => setView('landing')}>
            <ArrowLeft size={16} /> Back to Home
          </button>
        </header>

        <div className="consumer-container" style={{ textAlign: 'center', padding: '4rem 1.5rem' }}>
          <AlertTriangle size={48} style={{ color: 'var(--color-danger)', marginBottom: '1.5rem' }} />
          <h2>Traceability Record Not Found</h2>
          <p style={{ color: 'var(--color-text-muted)', margin: '1rem 0 2rem 0' }}>
            The ID <code>{traceId || "NULL"}</code> did not match any synthetic harvest or batch in the registry.
          </p>
          <button className="btn btn-primary" onClick={() => setView('landing')}>
            Return to Homepage
          </button>
        </div>
      </div>
    );
  }

  // Original parameters to tamper with
  const originalName = activeRecord.productName || (activeRecord.flowerSources ? activeRecord.flowerSources.join(' & ') + ' Honey' : 'Honey Harvest');
  const originalQuantity = activeRecord.batchQuantity || "Direct canister";
  const originalLab = activeRecord.labName || "Demo Honey Testing Laboratory";
  
  // Tampered values
  const displayName = isTampered ? `${originalName} (Altered in Transit)` : originalName;
  const displayQuantity = isTampered ? (isBatch ? "1,250 kg" : "Canister Weight: 45 kg (Modified)") : originalQuantity;
  const displayLabStatus = isTampered ? "Failed / Altered Report" : "Verified";
  const displayHash = isTampered ? "0000000000000000000000000000000000000000000000000000000000000000" : activeRecord.hash;

  return (
    <div className="consumer-layout">
      {/* Public Header */}
      <header className="consumer-header">
        <div className="logo-container" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
          <span className="logo-icon">
            <Hexagon size={28} fill="#F5A623" color="#D97706" strokeWidth={2} />
          </span>
          <span>HoneyChain</span>
        </div>
        <button 
          className="btn btn-secondary btn-sm" 
          onClick={() => setView('landing')}
        >
          <ArrowLeft size={16} /> Return to Portal
        </button>
      </header>

      <div className="consumer-container">
        
        {/* 1. BATCH VERIFIED BANNER */}
        <div className={`trace-status-banner ${isTampered ? 'status-tampered' : 'status-verified'}`}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
            {isTampered ? (
              <>
                <AlertTriangle size={24} />
                <div>
                  <h3 style={{ margin: 0, color: 'var(--color-danger)' }}>⚠ Record Integrity Mismatch</h3>
                  <p style={{ margin: 0, fontSize: '0.8rem', opacity: 0.9 }}>
                    Active record details do not match the hash committed on the blockchain ledger.
                  </p>
                </div>
              </>
            ) : (
              <>
                <ShieldCheck size={24} />
                <div>
                  <h3 style={{ margin: 0, color: 'var(--color-secondary-dark)' }}>✓ Blockchain Integrity Verified</h3>
                  <p style={{ margin: 0, fontSize: '0.8rem', opacity: 0.9 }}>
                    Tamper-evident record matches cryptographic block commitment.
                  </p>
                </div>
              </>
            )}
          </div>
          <span style={{ fontSize: '0.8rem', fontWeight: 700, padding: '0.25rem 0.75rem', borderRadius: '9999px', backgroundColor: 'rgba(255,255,255,0.4)' }}>
            {isBatch ? 'BLENDED BATCH' : 'DIRECT HARVEST'}
          </span>
        </div>

        {/* 2. PRODUCT INFORMATION */}
        <div className="trace-section" style={{ padding: '2.5rem', borderLeft: isTampered ? '6px solid var(--color-danger)' : '6px solid var(--color-primary)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.5rem' }}>
            <div>
              <span style={{ fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.05em', color: 'var(--color-text-light)', fontWeight: 600 }}>
                {isBatch ? 'BATCH ID / REFERENCE' : 'HARVEST ID / REFERENCE'}
              </span>
              <h2 style={{ fontSize: '1.5rem', fontFamily: 'monospace', color: isTampered ? 'var(--color-danger)' : 'var(--color-text-main)', marginTop: '0.25rem' }}>
                {activeRecord.batchId || activeRecord.harvestId}
              </h2>
            </div>
            <div style={{ textAlign: 'right' }}>
              <span style={{ fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.05em', color: 'var(--color-text-light)', fontWeight: 600 }}>
                Trace Date
              </span>
              <div style={{ fontWeight: 600, fontSize: '1.1rem', marginTop: '0.25rem' }}>{activeRecord.createdDate || activeRecord.harvestDate}</div>
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '2rem', borderTop: '1px solid var(--color-border)', paddingTop: '1.5rem' }}>
            <div>
              <div style={{ fontSize: '0.82rem', color: 'var(--color-text-muted)', marginBottom: '0.25rem' }}>Product Label</div>
              <strong style={{ fontSize: '1.1rem', color: isTampered ? 'var(--color-danger)' : 'inherit' }}>
                {displayName}
              </strong>
            </div>
            <div>
              <div style={{ fontSize: '0.82rem', color: 'var(--color-text-muted)', marginBottom: '0.25rem' }}>Trace Quantity</div>
              <strong style={{ fontSize: '1.1rem', color: isTampered ? 'var(--color-danger)' : 'inherit' }}>
                {displayQuantity}
              </strong>
            </div>
          </div>
        </div>

        {/* 3. SOURCE HARVESTS */}
        <section className="trace-section">
          <h3>
            <Clipboard size={18} />
            Source Harvests
          </h3>
          <p style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem' }}>
            The following contributing raw harvests were blended into this commercial product batch.
          </p>
          
          <div className="source-harvests-grid">
            {sourceHarvestsList.map(h => (
              <div key={h.harvestId} className="source-harvest-item" style={{ padding: '1.5rem' }}>
                <div className="source-harvest-header">
                  <span className="source-harvest-title" style={{ fontSize: '1rem', color: 'var(--color-text-main)' }}>
                    Harvest ID: <code style={{ fontSize: '0.95rem' }}>{h.harvestId}</code>
                  </span>
                  <span className="badge-active" style={{ fontSize: '0.7rem' }}>
                    ✓ Raw Origin Verified
                  </span>
                </div>
                
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: '1.25rem', fontSize: '0.88rem', marginTop: '0.75rem' }}>
                  <div>
                    <span style={{ color: 'var(--color-text-light)' }}>Harvest Date</span>
                    <div style={{ fontWeight: 600, marginTop: '0.15rem' }}>{h.harvestDate}</div>
                  </div>
                  <div>
                    <span style={{ color: 'var(--color-text-light)' }}>Floral Source</span>
                    <div style={{ marginTop: '0.15rem' }}>
                      {h.flowerSources.map(f => (
                        <span key={f} className="badge-active" style={{ marginRight: '0.25rem', backgroundColor: '#FEF3C7', color: '#D97706', fontSize: '0.75rem' }}>
                          {f}
                        </span>
                      ))}
                    </div>
                  </div>
                  <div>
                    <span style={{ color: 'var(--color-text-light)' }}>Extraction Site</span>
                    <div style={{ fontWeight: 600, marginTop: '0.15rem' }}>{h.locationName}</div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* 4. BEEKEEPERS */}
        <section className="trace-section">
          <h3>
            <User size={18} />
            Beekeepers
          </h3>
          <p style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem' }}>
            Verified independent apiary managers responsible for extracting the contributing harvests.
          </p>

          <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
            {sourceHarvestsList.map(h => (
              <div key={h.beekeeperId} className="verify-results" style={{ margin: 0, padding: '1.5rem', border: '1px solid var(--color-border)', borderRadius: 'var(--radius-md)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#FCFBF8' }}>
                <div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.25rem' }}>
                    <strong style={{ fontSize: '1rem' }}>{h.beekeeperName}</strong>
                    <span className="badge-active" style={{ fontSize: '0.7rem' }}>
                      ✓ Verified Identity
                    </span>
                  </div>
                  <div style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>
                    Registry ID: <code style={{ fontSize: '0.8rem' }}>{h.beekeeperId}</code> | Jurisdiction State: <strong>{h.state}</strong>
                  </div>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', color: 'var(--color-secondary-dark)', fontWeight: 600, fontSize: '0.88rem' }}>
                  <ShieldCheck size={16} /> Registry Active
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* 5. COMPANY / PROCESSOR */}
        {isBatch && (
          <section className="trace-section">
            <h3>
              <Building size={18} />
              Company / Processor
            </h3>
            <p style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem' }}>
              Licensed commercial processing and bottling business that blended and packaged this batch.
            </p>

            <div className="verify-results" style={{ margin: 0, padding: '1.5rem', border: '1px solid var(--color-border)', borderRadius: 'var(--radius-md)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#FCFBF8' }}>
              <div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.25rem' }}>
                  <strong style={{ fontSize: '1rem' }}>{activeRecord.companyName}</strong>
                  <span className="badge-active" style={{ fontSize: '0.7rem', backgroundColor: 'var(--color-secondary-light)', color: 'var(--color-secondary-dark)' }}>
                    ✓ FSSAI Licensed
                  </span>
                </div>
                <div style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>
                  Business License: <code style={{ fontSize: '0.8rem' }}>{activeRecord.licenseNumber}</code> | State Authority: <strong>{activeRecord.state || 'Uttar Pradesh'}</strong>
                </div>
                <div style={{ fontSize: '0.78rem', color: 'var(--color-text-light)', marginTop: '0.5rem', fontStyle: 'italic' }}>
                  Processing parameters: {activeRecord.processingInfo}
                </div>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', color: 'var(--color-secondary-dark)', fontWeight: 600, fontSize: '0.88rem' }}>
                <ShieldCheck size={16} /> Registry Active
              </div>
            </div>
          </section>
        )}

        {/* 6. LABORATORY VERIFICATION */}
        <section className="trace-section">
          <h3>
            <FileText size={18} />
            Laboratory Verification
          </h3>
          <p style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem' }}>
            Verification of purity indices performed at accredited laboratories before batch packaging.
          </p>
          
          <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr', gap: '2.5rem', flexWrap: 'wrap' }}>
            <div>
              <h4 style={{ fontSize: '1.1rem', marginBottom: '0.5rem' }}>{originalLab}</h4>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '1rem' }}>
                <span className="badge-active" style={{ 
                  backgroundColor: isTampered ? 'var(--color-danger-light)' : 'var(--color-success-light)', 
                  color: isTampered ? 'var(--color-danger)' : 'var(--color-secondary-dark)',
                  fontWeight: 700 
                }}>
                  Purity Status: {displayLabStatus}
                </span>
                <span style={{ fontSize: '0.8rem', color: 'var(--color-text-light)' }}>NABL ID: LAB-SYN-00001</span>
              </div>

              <p style={{ fontSize: '0.88rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem', lineHeight: '1.6' }}>
                Tested parameters verify compliance with moisture limit standard indicators (under 18% moisture, C4 sugar compliance, and specific pollen count indices). 
              </p>

              <button className="btn btn-secondary" onClick={() => setShowReportModal(true)} style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem' }}>
                <FileText size={16} /> View Lab Analysis Report
              </button>
            </div>

            <div style={{ borderLeft: '1px dashed var(--color-border)', paddingLeft: '2.5rem' }}>
              <h5 style={{ fontSize: '0.85rem', textTransform: 'uppercase', color: 'var(--color-text-muted)', marginBottom: '0.75rem', letterSpacing: '0.05em' }}>Purity Parameters</h5>
              <ul style={{ listStyle: 'none', fontSize: '0.85rem', display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                <li style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>Moisture Content:</span> 
                  <strong style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-success)' }}>17.4% (Pass)</strong>
                </li>
                <li style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>Fructose/Glucose Ratio:</span> 
                  <strong style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-success)' }}>1.28 (Pass)</strong>
                </li>
                <li style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>C4 Sugar Screen:</span> 
                  <strong style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-success)' }}>Negative (Pass)</strong>
                </li>
                <li style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>Heavy Metal Residue:</span> 
                  <strong>Nil (Pass)</strong>
                </li>
              </ul>
            </div>
          </div>

          <div className="disclaimer-box" style={{ marginTop: '2rem', backgroundColor: '#F9FAFB' }}>
            <strong>Purity Reference Notice:</strong> Fictional testing indicators are based on standard values. Laboratory checks indicate tested parameters matching standard thresholds. Purity indicators are for information purposes and do not represent absolute guarantees of chemical purity or trace honesty.
          </div>
        </section>

        {/* 7. BLOCKCHAIN INTEGRITY */}
        <section className="trace-section">
          <div 
            className="blockchain-drawer-header" 
            onClick={() => setShowBlockchainDetails(!showBlockchainDetails)}
            style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'pointer' }}
          >
            <h3 style={{ margin: 0, border: 'none', padding: 0, display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <ShieldCheck size={18} style={{ color: 'var(--color-accent)' }} /> 
              Blockchain Integrity
            </h3>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
              <span className="badge-active" style={{ backgroundColor: isTampered ? 'var(--color-danger-light)' : 'var(--color-accent-light)', color: isTampered ? 'var(--color-danger)' : 'var(--color-accent-dark)', fontWeight: 700 }}>
                {isTampered ? 'Integrity Mismatch' : 'Record Verified'}
              </span>
              {showBlockchainDetails ? <ChevronUp size={20} /> : <ChevronDown size={20} />}
            </div>
          </div>

          {showBlockchainDetails && (
            <div className="blockchain-drawer-content" style={{ borderLeft: isTampered ? '3px solid var(--color-danger)' : '3px solid var(--color-accent)', padding: '1.5rem', backgroundColor: '#F9FAF7', borderRadius: 'var(--radius-md)', marginTop: '1.5rem' }}>
              <div className="blockchain-info-row">
                <div className="blockchain-info-label" style={{ fontWeight: 600, fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>Current Data Block Hash (SHA-256)</div>
                <div className="blockchain-info-val" style={{ fontFamily: 'monospace', fontSize: '0.78rem', color: isTampered ? 'var(--color-danger)' : 'var(--color-accent-dark)', wordBreak: 'break-all', marginTop: '0.15rem' }}>
                  {displayHash}
                </div>
              </div>
              <div className="blockchain-info-row" style={{ marginTop: '1.25rem' }}>
                <div className="blockchain-info-label" style={{ fontWeight: 600, fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>Expected Blockchain Ledger Commitment</div>
                <div className="blockchain-info-val" style={{ fontFamily: 'monospace', fontSize: '0.78rem', color: 'var(--color-text-main)', wordBreak: 'break-all', marginTop: '0.15rem' }}>
                  {activeRecord.hash}
                </div>
              </div>
              <div className="blockchain-info-row" style={{ marginTop: '1.25rem' }}>
                <div className="blockchain-info-label" style={{ fontWeight: 600, fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>Previous Block Hash Reference</div>
                <div className="blockchain-info-val" style={{ fontFamily: 'monospace', fontSize: '0.78rem', color: 'var(--color-text-light)', wordBreak: 'break-all', marginTop: '0.15rem' }}>
                  {activeRecord.previousHash}
                </div>
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginTop: '1.25rem', borderTop: '1px dashed var(--color-border)', paddingTop: '1.25rem' }}>
                <div className="blockchain-info-row">
                  <div className="blockchain-info-label" style={{ fontWeight: 600, fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>Receipt Timestamp</div>
                  <div className="blockchain-info-val" style={{ fontSize: '0.85rem', marginTop: '0.15rem' }}>{activeRecord.timestamp}</div>
                </div>
                <div className="blockchain-info-row">
                  <div className="blockchain-info-label" style={{ fontWeight: 600, fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>Transaction Reference</div>
                  <div className="blockchain-info-val" style={{ fontFamily: 'monospace', fontSize: '0.78rem', color: 'var(--color-text-main)', wordBreak: 'break-all', marginTop: '0.15rem' }}>{activeRecord.txRef}</div>
                </div>
              </div>
              <p style={{ marginTop: '1.25rem', fontSize: '0.78rem', color: 'var(--color-text-light)', fontFamily: 'sans-serif', lineHeight: '1.5' }}>
                ✓ Records are committed into a blockchain structure. If any payload details are edited, the verification check fails because the recalculated hash does not match the ledger commitment.
              </p>
            </div>
          )}
        </section>

      </div>

      {/* Floating Tamper Control Widget */}
      <div className="tamper-control-float">
        <div className="tamper-control-title">
          🛠 Hackathon Demo Controls
        </div>
        <label className="tamper-toggle-label">
          <input 
            type="checkbox" 
            checked={isTampered}
            onChange={(e) => setIsTampered(e.target.checked)}
            style={{ cursor: 'pointer' }}
          />
          <span>Simulate Product Tampering</span>
        </label>
        <p style={{ fontSize: '0.7rem', color: '#9CA3AF', margin: 0 }}>
          Check this box to edit data in transit. You will instantly see how blockchain verification fails due to hash integrity checks.
        </p>
      </div>

      {/* Lab Report Simulation Modal */}
      {showReportModal && (
        <div className="modal-overlay">
          <div className="modal-content" style={{ maxWidth: '600px' }}>
            <div className="modal-header">
              <h3>Honey Purity Analysis Report</h3>
              <button style={{ background: 'none', border: 'none', cursor: 'pointer' }} onClick={() => setShowReportModal(false)}>
                ✕
              </button>
            </div>
            
            <div style={{ fontFamily: 'monospace', backgroundColor: '#F9FAFB', border: '1px solid var(--color-border)', padding: '1.5rem', fontSize: '0.75rem', borderRadius: 'var(--radius-md)', maxHeight: '350px', overflowY: 'auto' }}>
              <div style={{ textAlign: 'center', borderBottom: '2px solid #333', paddingBottom: '1rem', marginBottom: '1rem' }}>
                <strong style={{ fontSize: '1rem' }}>OFFICIAL PURITY CERTIFICATE</strong> <br />
                {originalLab} <br />
                Accredited Reference: LAB-SYN-00001
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
                <div>
                  <strong>Batch Ref:</strong> {traceId} <br />
                  <strong>Test Date:</strong> {activeRecord.createdDate || activeRecord.harvestDate}
                </div>
                <div style={{ textAlign: 'right' }}>
                  <strong>Verifier:</strong> NABL Synthetic Registry <br />
                  <strong>Result:</strong> <span style={{ color: isTampered ? 'red' : 'green', fontWeight: 'bold' }}>{isTampered ? 'SUSPECT' : 'VERIFIED COMPLIANT'}</span>
                </div>
              </div>

              <table style={{ width: '100%', borderCollapse: 'collapse', marginTop: '1rem' }}>
                <thead>
                  <tr style={{ borderBottom: '1px solid #333' }}>
                    <th style={{ textAlign: 'left', padding: '0.25rem 0' }}>Parameter Tested</th>
                    <th style={{ textAlign: 'right', padding: '0.25rem 0' }}>FSSAI Limit</th>
                    <th style={{ textAlign: 'right', padding: '0.25rem 0' }}>Measured</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td style={{ padding: '0.25rem 0' }}>Moisture (Water)</td>
                    <td style={{ textAlign: 'right' }}>&lt; 20%</td>
                    <td style={{ textAlign: 'right', color: isTampered ? 'red' : 'inherit' }}>{isTampered ? '22.3% (FAIL)' : '17.4%'}</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.25rem 0' }}>Sucrose (Sugar)</td>
                    <td style={{ textAlign: 'right' }}>&lt; 5%</td>
                    <td style={{ textAlign: 'right', color: isTampered ? 'red' : 'inherit' }}>{isTampered ? '7.8% (FAIL)' : '2.1%'}</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.25rem 0' }}>Fructose/Glucose Ratio</td>
                    <td style={{ textAlign: 'right' }}>&gt; 1.0</td>
                    <td style={{ textAlign: 'right' }}>1.28</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.25rem 0' }}>C4 Sugar (Cane Screen)</td>
                    <td style={{ textAlign: 'right' }}>&lt; 7%</td>
                    <td style={{ textAlign: 'right', color: isTampered ? 'red' : 'inherit' }}>{isTampered ? '12.4% (FAIL)' : '1.4%'}</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.25rem 0' }}>Lead (Pb) Content</td>
                    <td style={{ textAlign: 'right' }}>&lt; 2.5ppm</td>
                    <td style={{ textAlign: 'right' }}>ND (Not Detected)</td>
                  </tr>
                </tbody>
              </table>

              <div style={{ marginTop: '1.5rem', borderTop: '1px dashed #DDD', paddingTop: '1rem', fontSize: '0.7rem', color: '#777' }}>
                Report Verification Hash: <br />
                <span style={{ color: isTampered ? 'red' : '#7C3AED' }}>{displayHash}</span>
              </div>
            </div>

            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowReportModal(false)}>
                Close
              </button>
              <button className="btn btn-primary" onClick={() => alert("Report printed successfully (Simulated).")}>
                Print Report
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
