import React, { useState } from 'react';
import { 
  Hexagon, LayoutDashboard, PlusCircle, Building, ShieldCheck, 
  Layers, FileText, Activity, Check, Upload, ArrowRight,
  LogOut, AlertCircle, Search
} from 'lucide-react';
import { generateMockHash } from '../data/mockData';

export default function CompanyDashboard({ 
  user, setView, harvests, batches, setBatches, history, setHistory, setActiveTraceId 
}) {
  const [activeSubTab, setActiveSubTab] = useState('overview'); // overview, create-batch, previous-batches
  
  // Step-by-step form state
  const [currentStep, setCurrentStep] = useState(1); // 1: Select Harvests, 2: Batch Info, 3: Lab Info, 4: Verifying/Done
  const [selectedHarvestIds, setSelectedHarvestIds] = useState([]);
  const [productName, setProductName] = useState('');
  const [batchQuantity, setBatchQuantity] = useState('');
  const [processingInfo, setProcessingInfo] = useState('');
  const [labName, setLabName] = useState('Demo Honey Testing Laboratory');
  const [labReportFile, setLabReportFile] = useState(null);

  // Verification simulation state
  const [verificationStep, setVerificationStep] = useState(0); // 0: idle, 1: license check, 2: harvest trace check, 3: lab check, 4: done
  const [createdBatchId, setCreatedBatchId] = useState(null);

  // Search filter for harvests
  const [harvestSearch, setHarvestSearch] = useState('');

  // Handle source harvest selection toggle
  const toggleHarvestSelection = (id) => {
    if (selectedHarvestIds.includes(id)) {
      setSelectedHarvestIds(selectedHarvestIds.filter(hid => hid !== id));
    } else {
      setSelectedHarvestIds([...selectedHarvestIds, id]);
    }
  };

  // Run mock verification workflow
  const handleCreateBatch = (e) => {
    e.preventDefault();
    if (!productName || !batchQuantity) {
      alert("Please fill in the product name and batch quantity.");
      return;
    }
    
    // Begin step-by-step animation
    setCurrentStep(4);
    setVerificationStep(1);

    setTimeout(() => {
      setVerificationStep(2);
      
      setTimeout(() => {
        setVerificationStep(3);
        
        setTimeout(() => {
          setVerificationStep(4);
          
          // Generate unique batch ID
          const bCount = batches.length + 1;
          const dateStr = new Date().toISOString().split('T')[0].replace(/-/g, '');
          const licenseSuffix = user.licenseNumber.substring(user.licenseNumber.lastIndexOf('-') + 1);
          const newBatchId = `BT-${licenseSuffix}-${dateStr}-0${bCount}`;

          const rawString = `${newBatchId}|${user.companyName}|${selectedHarvestIds.join(',')}|${productName}`;
          const hashVal = generateMockHash(rawString);

          const newBatch = {
            batchId: newBatchId,
            companyName: user.companyName,
            licenseNumber: user.licenseNumber,
            productName: productName,
            batchQuantity: batchQuantity,
            processingInfo: processingInfo || "Blended and filtered for consistent density and moisture content.",
            createdDate: new Date().toISOString().split('T')[0],
            labName: labName,
            labReference: "LAB-SYN-00001",
            labReportName: labReportFile ? labReportFile.name : "batch_report_sih_demo.pdf",
            labStatus: "Verified",
            blockchainStatus: "Verified",
            sourceHarvestIds: selectedHarvestIds,
            hash: hashVal,
            previousHash: batches[0]?.hash || "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
            txRef: "0x" + generateMockHash(hashVal).substring(0, 60),
            timestamp: new Date().toISOString()
          };

          setBatches([newBatch, ...batches]);
          setCreatedBatchId(newBatchId);

          // Log in audit history
          const newHistoryItem = {
            id: `H-${Date.now()}`,
            timestamp: new Date().toISOString(),
            type: "Batch Generated",
            details: `Created Batch ${newBatchId} containing ${selectedHarvestIds.length} source harvests for product: ${productName}.`
          };
          setHistory([newHistoryItem, ...history]);

        }, 1000);
      }, 1000);
    }, 1000);
  };

  const resetBatchForm = () => {
    setCurrentStep(1);
    setVerificationStep(0);
    setCreatedBatchId(null);
    setSelectedHarvestIds([]);
    setProductName('');
    setBatchQuantity('');
    setProcessingInfo('');
    setLabReportFile(null);
  };

  // Calculate unique beekeepers from selected harvests
  const selectedHarvestDetails = harvests.filter(h => selectedHarvestIds.includes(h.harvestId));
  const uniqueBeekeepers = new Set(selectedHarvestDetails.map(h => h.beekeeperId)).size;

  // Filter harvests by search query
  const filteredHarvests = harvests.filter(h => 
    h.harvestId.toLowerCase().includes(harvestSearch.toLowerCase()) ||
    h.beekeeperName.toLowerCase().includes(harvestSearch.toLowerCase()) ||
    h.flowerSources.join(' ').toLowerCase().includes(harvestSearch.toLowerCase())
  );

  return (
    <div className="dashboard-layout">
      {/* Sidebar */}
      <aside className="sidebar">
        <div className="sidebar-header">
          <Hexagon size={24} fill="#F5A623" color="#D97706" strokeWidth={2} />
          <span className="sidebar-logo-text">HoneyChain</span>
        </div>

        <ul className="sidebar-menu">
          <li className="sidebar-label">Dashboard</li>
          <li 
            className={`sidebar-item ${activeSubTab === 'overview' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('overview')}
          >
            <LayoutDashboard size={18} />
            <span>Overview</span>
          </li>

          <li className="sidebar-label">Traceability</li>
          <li 
            className={`sidebar-item ${activeSubTab === 'create-batch' ? 'active' : ''}`}
            onClick={() => { resetBatchForm(); setActiveSubTab('create-batch'); }}
          >
            <PlusCircle size={18} />
            <span>Create Batch</span>
          </li>
          <li 
            className={`sidebar-item ${activeSubTab === 'previous-batches' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('previous-batches')}
          >
            <Layers size={18} />
            <span>Previous Batches</span>
          </li>
        </ul>

        <div className="sidebar-footer">
          <div className="sidebar-profile" style={{ marginBottom: "1rem" }}>
            <div className="sidebar-avatar" style={{ backgroundColor: "var(--color-secondary-dark)" }}>
              {user.companyName.split(' ').map(n => n[0]).join('')}
            </div>
            <div>
              <div style={{ fontWeight: 600, fontSize: "0.9rem" }}>{user.companyName}</div>
              <div style={{ fontSize: "0.75rem", color: "rgba(255,255,255,0.5)" }}>Licensed Processor</div>
            </div>
          </div>
          <div 
            className="sidebar-item" 
            onClick={() => { setView('role-selection'); }}
            style={{ color: "#FCA5A5", padding: "0.5rem" }}
          >
            <LogOut size={16} />
            <span>Exit Dashboard</span>
          </div>
        </div>
      </aside>

      {/* Main Panel */}
      <main className="dashboard-main">
        {/* Header */}
        <header className="dashboard-header">
          <div className="dashboard-title-area">
            <h1>Company Processing Portal</h1>
            <p>Blend verifiable harvests into commercial batches</p>
          </div>
          <div style={{ display: "flex", alignItems: "center", gap: "1rem" }}>
            <span className="badge-active" style={{ display: "inline-flex", alignItems: "center", gap: "0.25rem", backgroundColor: "var(--color-secondary-light)", color: "var(--color-secondary-dark)" }}>
              <Building size={14} /> License: {user.licenseNumber}
            </span>
          </div>
        </header>

        {/* Dashboard Body */}
        <div className="dashboard-body">
          
          {/* TAB 1: OVERVIEW */}
          {activeSubTab === 'overview' && (
            <div>
              {/* Summary Cards */}
              <div className="stats-grid">
                <div className="stats-card">
                  <div className="stats-icon-box icon-purple">
                    <Layers size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Total Batches</h4>
                    <p>{batches.length}</p>
                  </div>
                </div>

                <div className="stats-card">
                  <div className="stats-icon-box icon-yellow">
                    <FileText size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Source Harvests</h4>
                    <p>{harvests.length}</p>
                  </div>
                </div>

                <div className="stats-card">
                  <div className="stats-icon-box icon-green">
                    <ShieldCheck size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Verified Labs</h4>
                    <p>2</p>
                  </div>
                </div>

                <div className="stats-card">
                  <div className="stats-icon-box icon-green" style={{ backgroundColor: "#F3E8FF", color: "#7C3AED" }}>
                    <Activity size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Blockchain Ledger</h4>
                    <p style={{ fontSize: "1.2rem", fontWeight: 600, marginTop: "0.25rem" }}>TAMPER-EVIDENT</p>
                  </div>
                </div>
              </div>

              {/* Batches Table */}
              <div className="table-card">
                <div className="table-card-header">
                  <h3>Recent Blended Batches</h3>
                  <button className="btn btn-green btn-sm" onClick={() => setActiveSubTab('create-batch')}>
                    <PlusCircle size={16} /> Create Batch
                  </button>
                </div>
                
                <div className="table-responsive">
                  <table className="custom-table">
                    <thead>
                      <tr>
                        <th>Batch ID</th>
                        <th>Product Name</th>
                        <th>Harvests Blended</th>
                        <th>Created Date</th>
                        <th>Lab Quality</th>
                        <th>Blockchain Status</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      {batches.length === 0 ? (
                        <tr>
                          <td colSpan="7" style={{ textAlign: "center", color: "var(--color-text-light)", padding: "2rem" }}>
                            No batches generated yet. Click "Create Batch" to start processing.
                          </td>
                        </tr>
                      ) : (
                        batches.map((b) => (
                          <tr key={b.batchId}>
                            <td style={{ fontWeight: 600 }}>{b.batchId}</td>
                            <td>{b.productName}</td>
                            <td>
                              <span className="badge-active" style={{ backgroundColor: "#F3F4F6", color: "var(--color-text-muted)" }}>
                                {b.sourceHarvestIds.length} Harvests
                              </span>
                            </td>
                            <td>{b.createdDate}</td>
                            <td>
                              <span className="badge-active" style={{ backgroundColor: "#D1FAE5", color: "#065F46" }}>
                                ✓ Verified Lab
                              </span>
                            </td>
                            <td>
                              <span className="blockchain-status-tag">
                                <ShieldCheck size={12} /> {b.blockchainStatus}
                              </span>
                            </td>
                            <td>
                              <button 
                                className="btn btn-secondary btn-sm"
                                onClick={() => {
                                  setActiveTraceId(b.batchId);
                                  setView('consumer-trace');
                                }}
                              >
                                Trace Batch
                              </button>
                            </td>
                          </tr>
                        ))
                      )}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}

          {/* TAB 2: CREATE BATCH FORM */}
          {activeSubTab === 'create-batch' && (
            <div className="form-card">
              <h2 style={{ marginBottom: "0.25rem" }}>Create Commercial Honey Batch</h2>
              <p style={{ color: "var(--color-text-muted)", fontSize: "0.9rem", marginBottom: "2rem" }}>
                Select verified source harvests from independent beekeepers, document processing controls, and verify laboratory testing credentials.
              </p>

              {/* Progress Indicator for Step Form */}
              {currentStep < 4 && (
                <div style={{ display: "flex", justifyContent: "space-between", marginBottom: "2.5rem", position: "relative" }}>
                  <div style={{ position: "absolute", top: "50%", left: "0", right: "0", height: "2px", backgroundColor: "var(--color-border)", zIndex: 0, transform: "translateY(-50%)" }}></div>
                  
                  <div className={`flow-step`} style={{ zIndex: 1, backgroundColor: "var(--color-card-bg)", padding: "0 0.5rem" }}>
                    <div className={`flow-circle ${currentStep >= 1 ? 'active' : ''}`} style={{ margin: "0 auto 0.25rem auto" }}>1</div>
                    <span style={{ fontSize: "0.75rem", fontWeight: currentStep === 1 ? 700 : 500 }}>Select Harvests</span>
                  </div>

                  <div className={`flow-step`} style={{ zIndex: 1, backgroundColor: "var(--color-card-bg)", padding: "0 0.5rem" }}>
                    <div className={`flow-circle ${currentStep >= 2 ? 'active' : ''}`} style={{ margin: "0 auto 0.25rem auto" }}>2</div>
                    <span style={{ fontSize: "0.75rem", fontWeight: currentStep === 2 ? 700 : 500 }}>Batch Details</span>
                  </div>

                  <div className={`flow-step`} style={{ zIndex: 1, backgroundColor: "var(--color-card-bg)", padding: "0 0.5rem" }}>
                    <div className={`flow-circle ${currentStep >= 3 ? 'active' : ''}`} style={{ margin: "0 auto 0.25rem auto" }}>3</div>
                    <span style={{ fontSize: "0.75rem", fontWeight: currentStep === 3 ? 700 : 500 }}>Lab Quality</span>
                  </div>
                </div>
              )}

              {/* STEP 1: SELECT HARVESTS */}
              {currentStep === 1 && (
                <div>
                  <h3 style={{ fontSize: "1.1rem", marginBottom: "1rem" }}>Step 1: Choose Source Honey Harvests</h3>
                  <p style={{ fontSize: "0.85rem", color: "var(--color-text-muted)", marginBottom: "1.5rem" }}>
                    Select one or more raw harvests extracted by verified beekeepers. One batch may contain honey from multiple harvests.
                  </p>

                  <div className="form-group" style={{ position: "relative" }}>
                    <input 
                      type="text" 
                      className="form-input" 
                      placeholder="Search harvests by ID, beekeeper, or flower source..." 
                      style={{ paddingLeft: "2.5rem" }}
                      value={harvestSearch}
                      onChange={(e) => setHarvestSearch(e.target.value)}
                    />
                    <Search size={16} style={{ position: "absolute", left: "0.75rem", top: "50%", transform: "translateY(-50%)", color: "var(--color-text-light)" }} />
                  </div>

                  {/* Harvest Selection List */}
                  <div style={{ display: "flex", flexDirection: "column", gap: "0.75rem", maxHeight: "300px", overflowY: "auto", border: "1px solid var(--color-border)", borderRadius: "var(--radius-md)", padding: "0.75rem", marginBottom: "1.5rem" }}>
                    {filteredHarvests.length === 0 ? (
                      <div style={{ textAlign: "center", color: "var(--color-text-light)", padding: "2rem" }}>
                        No matches found.
                      </div>
                    ) : (
                      filteredHarvests.map(h => (
                        <div 
                          key={h.harvestId} 
                          className={`verify-results ${selectedHarvestIds.includes(h.harvestId) ? 'verify-success' : ''}`}
                          style={{ margin: 0, padding: "0.85rem 1rem", cursor: "pointer", display: "flex", justifyContent: "space-between", alignItems: "center" }}
                          onClick={() => toggleHarvestSelection(h.harvestId)}
                        >
                          <div>
                            <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                              <span style={{ fontWeight: 700, fontSize: "0.9rem" }}>{h.harvestId}</span>
                              <span className="badge-active" style={{ fontSize: "0.7rem", backgroundColor: "#FEF3C7", color: "#D97706" }}>
                                {h.flowerSources.join('/')}
                              </span>
                            </div>
                            <div style={{ fontSize: "0.75rem", color: "var(--color-text-muted)", marginTop: "0.15rem" }}>
                              Beekeeper: <strong>{h.beekeeperName}</strong> ({h.beekeeperId}) | Date: {h.harvestDate}
                            </div>
                          </div>
                          <div>
                            <input 
                              type="checkbox" 
                              checked={selectedHarvestIds.includes(h.harvestId)}
                              onChange={() => {}} // toggled by parent div click
                              style={{ transform: "scale(1.25)", cursor: "pointer" }}
                            />
                          </div>
                        </div>
                      ))
                    )}
                  </div>

                  {/* Selection summary */}
                  <div style={{ display: "flex", justifyContent: "space-between", backgroundColor: "var(--color-neutral-bg)", padding: "1rem", borderRadius: "var(--radius-md)", border: "1px dashed var(--color-border)", marginBottom: "1.5rem" }}>
                    <div>Source Harvests: <strong>{selectedHarvestIds.length}</strong></div>
                    <div>Beekeepers: <strong>{uniqueBeekeepers}</strong></div>
                  </div>

                  <div style={{ display: "flex", justifyContent: "flex-end" }}>
                    <button 
                      className="btn btn-green"
                      disabled={selectedHarvestIds.length === 0}
                      onClick={() => setCurrentStep(2)}
                      style={{ display: "inline-flex", alignItems: "center", gap: "0.5rem" }}
                    >
                      Next: Batch Details <ArrowRight size={16} />
                    </button>
                  </div>
                </div>
              )}

              {/* STEP 2: BATCH INFO */}
              {currentStep === 2 && (
                <div>
                  <h3 style={{ fontSize: "1.1rem", marginBottom: "1.5rem" }}>Step 2: Processing & Packaging Details</h3>

                  <div className="form-grid-2">
                    <div className="form-group">
                      <label className="form-label" htmlFor="product-name-input">Commercial Product Name</label>
                      <input 
                        id="product-name-input"
                        type="text" 
                        className="form-input" 
                        placeholder="e.g. Wildflower Blossom Honey"
                        value={productName}
                        onChange={(e) => setProductName(e.target.value)}
                        required
                      />
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="batch-quantity-input">Blended Quantity (kg)</label>
                      <input 
                        id="batch-quantity-input"
                        type="text" 
                        className="form-input" 
                        placeholder="e.g. 500 kg"
                        value={batchQuantity}
                        onChange={(e) => setBatchQuantity(e.target.value)}
                        required
                      />
                    </div>
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="processing-info-textarea">Processing / Filtration / Mixture Notes</label>
                    <textarea 
                      id="processing-info-textarea"
                      className="form-input" 
                      rows="4" 
                      placeholder="Specify blending controls: e.g. Cold-filtration, moisture control at 18%, blended for flavor consistency..."
                      value={processingInfo}
                      onChange={(e) => setProcessingInfo(e.target.value)}
                    ></textarea>
                  </div>

                  <div style={{ display: "flex", justifyContent: "space-between", marginTop: "1.5rem" }}>
                    <button className="btn btn-secondary" onClick={() => setCurrentStep(1)}>
                      Back
                    </button>
                    <button 
                      className="btn btn-green"
                      onClick={() => setCurrentStep(3)}
                      disabled={!productName || !batchQuantity}
                      style={{ display: "inline-flex", alignItems: "center", gap: "0.5rem" }}
                    >
                      Next: Lab Quality <ArrowRight size={16} />
                    </button>
                  </div>
                </div>
              )}

              {/* STEP 3: LAB QUALITY */}
              {currentStep === 3 && (
                <div>
                  <h3 style={{ fontSize: "1.1rem", marginBottom: "1.5rem" }}>Step 3: Laboratory Quality Assurance</h3>

                  <div className="form-grid-2">
                    <div className="form-group">
                      <label className="form-label" htmlFor="batch-lab-select">Quality Inspection Lab</label>
                      <select 
                        id="batch-lab-select"
                        className="form-input"
                        value={labName}
                        onChange={(e) => {
                          setLabName(e.target.value);
                        }}
                      >
                        <option value="Demo Honey Testing Laboratory">Demo Honey Testing Laboratory (LAB-SYN-00001)</option>
                        <option value="National Honey Analytics">National Honey Analytics (LAB-SYN-00002)</option>
                      </select>
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="batch-report-upload">Upload Lab Report PDF</label>
                      <div className="file-upload-box" onClick={() => document.getElementById('batch-report-upload')?.click()}>
                        <Upload size={18} className="file-upload-icon" />
                        <div className="file-upload-text">
                          {labReportFile ? (
                            <strong style={{ color: "var(--color-secondary)" }}>{labReportFile.name} (Attached)</strong>
                          ) : "Click to select PDF report"}
                        </div>
                      </div>
                      <input 
                        id="batch-report-upload"
                        type="file" 
                        accept=".pdf" 
                        style={{ display: "none" }}
                        onChange={(e) => { if(e.target.files?.[0]) setLabReportFile(e.target.files[0]); }}
                      />
                    </div>
                  </div>

                  <div className="disclaimer-box" style={{ marginBottom: "2rem" }}>
                    <div style={{ display: "flex", gap: "0.4rem" }}>
                      <AlertCircle size={16} style={{ color: "var(--color-primary-dark)", flexShrink: 0, marginTop: "2px" }} />
                      <div>
                        <strong>Laboratory Verification:</strong> Connecting testing documentation ensures trace transparency. Purity parameters are verified for moisture limits and sucrose thresholds.
                      </div>
                    </div>
                  </div>

                  <div style={{ display: "flex", justifyContent: "space-between" }}>
                    <button className="btn btn-secondary" onClick={() => setCurrentStep(2)}>
                      Back
                    </button>
                    <button 
                      className="btn btn-primary"
                      onClick={handleCreateBatch}
                      style={{ display: "inline-flex", alignItems: "center", gap: "0.5rem" }}
                    >
                      Verify & Generate Batch Record
                    </button>
                  </div>
                </div>
              )}

              {/* STEP 4: VERIFICATION PROGRESS SCREEN */}
              {currentStep === 4 && (
                <div>
                  {verificationStep < 4 ? (
                    <div>
                      <h3 style={{ textAlign: "center", marginBottom: "1.5rem" }}>Verifying Honey Batch Integrity</h3>
                      <div style={{ display: "flex", justifyContent: "center", margin: "1rem 0" }}>
                        <div className="flow-circle active" style={{ animation: "pulse 1.5s infinite" }}>
                          {verificationStep}
                        </div>
                      </div>
                      <ul className="progress-list">
                        <li className={`progress-item ${verificationStep >= 1 ? 'completed' : ''}`}>
                          <span className={`progress-bullet ${verificationStep >= 1 ? 'bullet-success' : 'bullet-pending'}`}>
                            {verificationStep >= 1 ? '✓' : '1'}
                          </span>
                          <span>Verifying Company Processor License Status...</span>
                        </li>
                        <li className={`progress-item ${verificationStep >= 2 ? 'completed' : ''}`}>
                          <span className={`progress-bullet ${verificationStep >= 2 ? 'bullet-success' : 'bullet-pending'}`}>
                            {verificationStep >= 2 ? '✓' : '2'}
                          </span>
                          <span>Tracing Blockchain Source Harvests Ledger Signatures ({selectedHarvestIds.length} harvests)...</span>
                        </li>
                        <li className={`progress-item ${verificationStep >= 3 ? 'completed' : ''}`}>
                          <span className={`progress-bullet ${verificationStep >= 3 ? 'bullet-success' : 'bullet-pending'}`}>
                            {verificationStep >= 3 ? '✓' : '3'}
                          </span>
                          <span>Verifying Quality Laboratory QA PDF hash credentials...</span>
                        </li>
                        <li className="progress-item">
                          <span className="progress-bullet bullet-pending">4</span>
                          <span>Committing block headers to HoneyChain blockchain registry...</span>
                        </li>
                      </ul>
                    </div>
                  ) : (
                    <div className="success-screen">
                      <div className="success-icon-wrapper">
                        <Check size={32} />
                      </div>
                      <h3 className="success-title">Honey Batch Generated Successfully</h3>
                      <p style={{ fontSize: "0.85rem", color: "var(--color-text-muted)", marginBottom: "1.5rem" }}>
                        Blockchain ledger entry successfully committed under reference: <br />
                        <code style={{ fontSize: "0.8rem", color: "var(--color-accent-dark)" }}>{createdBatchId}</code>
                      </p>

                      <div className="qr-preview-box">
                        <div className="qr-code-placeholder"></div>
                        <div style={{ fontSize: "0.85rem", fontWeight: 700 }}>{createdBatchId}</div>
                        <button 
                          className="btn btn-secondary btn-sm"
                          onClick={() => alert("Simulated print sequence initiated. QR labels can now be affixed to commercial retail jars.")}
                        >
                          Print QR Labels
                        </button>
                      </div>

                      <div style={{ display: "flex", gap: "1rem", justifyContent: "center" }}>
                        <button className="btn btn-secondary" onClick={resetBatchForm}>
                          Create Another
                        </button>
                        <button 
                          className="btn btn-primary" 
                          onClick={() => {
                            setActiveTraceId(createdBatchId);
                            setView('consumer-trace');
                          }}
                        >
                          View Traceability Page
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}

          {/* TAB 3: PREVIOUS BATCHES */}
          {activeSubTab === 'previous-batches' && (
            <div className="table-card">
              <div className="table-card-header">
                <h3>Blended Batch Registry Logs</h3>
              </div>
              
              <div className="table-responsive">
                <table className="custom-table">
                  <thead>
                    <tr>
                      <th>Batch ID</th>
                      <th>Product Name</th>
                      <th>Quantity</th>
                      <th>Harvests</th>
                      <th>Created Date</th>
                      <th>Lab Status</th>
                      <th>Ledger Status</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {batches.length === 0 ? (
                      <tr>
                        <td colSpan="8" style={{ textAlign: "center", color: "var(--color-text-light)", padding: "2rem" }}>
                          No batches registered.
                        </td>
                      </tr>
                    ) : (
                      batches.map(b => (
                        <tr key={b.batchId}>
                          <td style={{ fontWeight: 600 }}>{b.batchId}</td>
                          <td>{b.productName}</td>
                          <td>{b.batchQuantity}</td>
                          <td>
                            <span className="badge-active" style={{ backgroundColor: "#F3F4F6", color: "var(--color-text-muted)" }}>
                              {b.sourceHarvestIds.length} Harvests
                            </span>
                          </td>
                          <td>{b.createdDate}</td>
                          <td>
                            <span className="badge-active" style={{ backgroundColor: "#D1FAE5", color: "#065F46" }}>
                              ✓ Checked
                            </span>
                          </td>
                          <td>
                            <span className="blockchain-status-tag">
                              <ShieldCheck size={12} /> {b.blockchainStatus}
                            </span>
                          </td>
                          <td>
                            <button 
                              className="btn btn-secondary btn-sm"
                              onClick={() => {
                                  setActiveTraceId(b.batchId);
                                  setView('consumer-trace');
                              }}
                            >
                              Trace Batch
                            </button>
                          </td>
                        </tr>
                      ))
                    )}
                  </tbody>
                </table>
              </div>
            </div>
          )}

        </div>
      </main>
    </div>
  );
}
