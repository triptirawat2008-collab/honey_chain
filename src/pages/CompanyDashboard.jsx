import React, { useState, useEffect } from 'react';
import { 
Hexagon, LayoutDashboard, PlusCircle, Building, ShieldCheck, 
Layers, FileText, Activity, Check, Upload, ArrowRight, ArrowLeft,
LogOut, AlertCircle, Search, QrCode, Printer, CheckCircle2,
Users, Sparkles, Filter, ChevronRight
} from 'lucide-react';
import { generateMockHash } from '../data/mockData';
import SpeakerButton from '../components/SpeakerButton';

export default function CompanyDashboard({ 
  user, setView, harvests, batches, setBatches, history, setHistory, setActiveTraceId,
  primaryLang = 'hi'
}) {
  const [activeSubTab, setActiveSubTab] = useState('overview'); // overview, create-batch, previous-batches
  
  // Step-by-step form state
  const [currentStep, setCurrentStep] = useState(1); // 1: Select Harvests, 2: Batch Info, 3: Lab Info, 4: Verifying/Done
  const [selectedHarvestIds, setSelectedHarvestIds] = useState([]); 
  const [harvestIdInput, setHarvestIdInput] = useState('');
  const [harvestIdError, setHarvestIdError] = useState('');
  const [productName, setProductName] = useState('Raw Organic Mustard & Multifloral Honey (500g Jar)');
  const [batchQuantity, setBatchQuantity] = useState('500 kg (1,000 Jars)');
  const [processingInfo, setProcessingInfo] = useState('Cold-filtered at <40°C, zero additives, moisture standardized to 17.4%.');
  const [labName, setLabName] = useState('Demo Honey Testing Laboratory (NABL #104)');
  const [labReportFile, setLabReportFile] = useState(null);

  // Verification simulation state
  const [verificationStep, setVerificationStep] = useState(0);
  const [createdBatchId, setCreatedBatchId] = useState(null);

  // Search filter for harvests
  const [harvestSearch, setHarvestSearch] = useState('');

  // Handle source harvest selection toggle
  const toggleHarvestSelection = (id) => {
    if (selectedHarvestIds.includes(id)) {
      if (selectedHarvestIds.length > 1) {
        setSelectedHarvestIds(selectedHarvestIds.filter(hid => hid !== id));
      }
    } else {
      setSelectedHarvestIds([...selectedHarvestIds, id]);
    }
  };

  const addHarvestId = async () => {
  const id = harvestIdInput.trim();

  if (!id) {
    setHarvestIdError('Please enter a Harvest ID.');
    return;
  }

  if (selectedHarvestIds.includes(id)) {
    setHarvestIdError('This Harvest ID has already been added.');
    return;
  }

  try {
    const response = await fetch(
      `http://localhost:5000/api/harvests/verify/${encodeURIComponent(id)}`
    );

    const result = await response.json();

    if (!response.ok || !result.verified) {
      setHarvestIdError('Harvest ID not found in the database.');
      return;
    }

    setSelectedHarvestIds(prev => [...prev, id]);
    setHarvestIdInput('');
    setHarvestIdError('');
  } catch (error) {
    console.error('Harvest verification error:', error);
    setHarvestIdError('Could not verify Harvest ID. Please check the backend.');
  }
};

  // Run mock verification workflow
const handleCreateBatch = async (e) => {
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
        
      setTimeout(async () => {
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
            fssaiNumber: user.fssaiNumber || "FSSAI 10021051000124",
            productName: productName,
            productNameHi: productName,
            batchQuantity: batchQuantity,
            processingInfo: processingInfo || "Cold-filtered at <40°C, zero additives, moisture standardized to 17.4%.",
            createdDate: new Date().toISOString().split('T')[0],
            labName: labName,
            labReference: "LAB-SYN-00001",
            labReportName: labReportFile ? labReportFile.name : "batch_report_sih_demo.pdf",
            labStatus: "Verified",
            blockchainStatus: "Verified",
            sourceHarvestIds: selectedHarvestIds,
            blockNumber: 148922,
            hash: hashVal,
            previousHash: batches[0]?.hash || "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
            txRef: "0x" + generateMockHash(hashVal).substring(0, 60),
            timestamp: new Date().toISOString()
          };
          const batchPayload = {
  batch_id: newBatchId,
  company_license: user.licenseNumber,
  product_name: productName,
  quantity_kg: parseFloat(batchQuantity) || 500,
  final_lab_ulr: null,
  ulr_status: "Verified",
  manual_report_certified: !!labReportFile,
  is_lab_certified: true,
  harvest_ids: selectedHarvestIds
};

const response = await fetch('http://localhost:5000/api/batches', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify(batchPayload)
});

const result = await response.json();

if (!response.ok || !result.success) {
  console.error("Failed to save batch:", result);

  alert(
    "Database Error: Could not save the batch.\n\n" +
    (result.error || "Unknown database error")
  );

  setCurrentStep(3);
  setVerificationStep(0);
  return;
}

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

        }, 900);
      }, 900);
    }, 900);
  };

const resetBatchForm = () => {
  setCurrentStep(1);
  setVerificationStep(0);
  setCreatedBatchId(null);

  // Start with NO harvest selected
  setSelectedHarvestIds([]);
  setHarvestIdInput('');

  setProductName('Raw Organic Mustard & Multifloral Honey (500g Jar)');
  setBatchQuantity('500 kg (1,000 Jars)');
  setProcessingInfo(
    'Cold-filtered at <40°C, zero additives, moisture standardized to 17.4%.'
  );
  setLabReportFile(null);
};

  // Calculate unique beekeepers from selected harvests
  const selectedHarvestDetails = harvests.filter(h => selectedHarvestIds.includes(h.harvestId));
  const uniqueBeekeepers = selectedHarvestIds.length;
  const totalVolume = batches.reduce((acc, curr) => acc + (parseInt(curr.batchQuantity) || 500), 0);

  // Filter harvests by search query
  const filteredHarvests = harvests.filter(h => 
    h.harvestId.toLowerCase().includes(harvestSearch.toLowerCase()) ||
    h.beekeeperName.toLowerCase().includes(harvestSearch.toLowerCase()) ||
    h.flowerSources.join(' ').toLowerCase().includes(harvestSearch.toLowerCase())
  );
useEffect(() => {
  const loadCompanyBatches = async () => {
    if (!user?.licenseNumber) return;

    try {
      const response = await fetch(
        `http://localhost:5000/api/batches/${encodeURIComponent(user.licenseNumber)}`
      );

      const result = await response.json();

      console.log("Batches loaded from PostgreSQL:", result);

      if (result.success) {
        const loadedBatches = result.data.map(b => ({
          batchId: b.batch_id,
          companyName: user.companyName,
          licenseNumber: b.company_license,

          productName: b.product_name,
          productNameHi: b.product_name,

          batchQuantity: `${b.quantity_kg} kg`,

          labReference: b.final_lab_ulr || "",
          labStatus: b.ulr_status || "Verified",

          sourceHarvestIds: b.harvest_ids || [],

          // These aren't currently stored in batches table
          processingInfo: "",
          labName: "",
          labReportName: "",
          blockchainStatus: "Verified",
          blockNumber: null,
          hash: "",
          previousHash: "",
          txRef: "",

          createdDate: b.created_at
            ? new Date(b.created_at).toISOString().split('T')[0]
            : "",

          timestamp: b.created_at || ""
        }));

        setBatches(loadedBatches);
      }

    } catch (error) {
      console.error("Error loading company batches:", error);
    }
  };

  loadCompanyBatches();
}, [user?.licenseNumber]);
  return (
    <div className="dashboard-layout">
      {/* Sidebar */}
      <aside className="sidebar">
        <div className="sidebar-header" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
          <Hexagon size={28} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
          <div>
            <span className="sidebar-logo-text">HoneyChain</span>
            <div style={{ fontSize: '0.72rem', color: '#DCFCE7', fontWeight: 600 }}>कंपनी पोर्टल • FSSAI Licensed</div>
          </div>
        </div>

        <ul className="sidebar-menu">
          <li className="sidebar-label">{primaryLang === 'hi' ? 'कंपनी डैशबोर्ड' : 'Processor Dashboard'}</li>
          
          <li 
            className={`sidebar-item ${activeSubTab === 'overview' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('overview')}
          >
            <LayoutDashboard size={18} />
            <span>{primaryLang === 'hi' ? 'डैशबोर्ड विवरण' : 'Overview'}</span>
          </li>

          <li className="sidebar-label">{primaryLang === 'hi' ? 'बैच व पैकेजिंग' : 'Batching & Bottling'}</li>
          
          <li 
            className={`sidebar-item sidebar-item-highlight ${activeSubTab === 'create-batch' ? 'active' : ''}`}
            onClick={() => { resetBatchForm(); setActiveSubTab('create-batch'); }}
          >
            <PlusCircle size={18} />
            <span>{primaryLang === 'hi' ? '➕ नया बैच बनाएं' : '➕ Create New Batch'}</span>
          </li>
          
          <li 
            className={`sidebar-item ${activeSubTab === 'previous-batches' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('previous-batches')}
          >
            <Layers size={18} />
            <span>{primaryLang === 'hi' ? 'निर्मित बैच (Master QR)' : 'Master Batches'}</span>
          </li>
        </ul>

        <div className="sidebar-footer">
          <div className="sidebar-profile" style={{ marginBottom: '1rem' }}>
            <div className="sidebar-avatar" style={{ backgroundColor: 'var(--color-secondary-dark)' }}>
              🏢
            </div>
            <div>
              <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>{user.companyName}</div>
              <div style={{ fontSize: '0.75rem', color: 'rgba(255,255,255,0.7)' }}>{user.licenseNumber}</div>
            </div>
          </div>
          <div 
            className="sidebar-item" 
            onClick={() => setView('role-selection')}
            style={{ color: '#FCA5A5', padding: '0.5rem', cursor: 'pointer' }}
          >
            <LogOut size={16} />
            <span>{primaryLang === 'hi' ? 'बाहर जाएं (Logout)' : 'Exit Dashboard'}</span>
          </div>
        </div>
      </aside>

      {/* Main Panel */}
      <main className="dashboard-main">
        {/* Header */}
        <header className="dashboard-header">
          <div className="dashboard-title-area">
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <h1>{primaryLang === 'hi' ? 'कंपनी एवं एफपीओ प्रसंस्करण पोर्टल' : 'Company & FPO Processing Portal'}</h1>
              <SpeakerButton 
                text={primaryLang === 'hi' 
                  ? "कंपनी व एफपीओ पोर्टल। किसानों से प्राप्त कच्ची शहद को मिलाकर उपभोक्ता बोतलों के लिए मास्टर QR कोड बनाएं।"
                  : "Company and FPO portal. Blend verified raw farmer harvests into commercial batches with master bottle QR codes."}
                lang={primaryLang}
                size={18}
              />
            </div>
            <p>{primaryLang === 'hi' ? 'कच्ची शहद का संकलन, ब्लेंडिंग और बोतल लेबल मास्टर QR कोड' : 'Raw honey aggregation, batch blending, and master QR code generation'}</p>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
            <span className="badge-active" style={{ display: 'inline-flex', alignItems: 'center', gap: '0.35rem', backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 700, padding: '0.5rem 0.9rem' }}>
              <Building size={16} /> {user.fssaiNumber || user.licenseNumber}
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
                <div className="stats-card-rural">
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#F3E8FF', color: '#7C3AED' }}>
                    📦
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'कुल बैच निर्मित' : 'Batches Created'}</h4>
                    <p className="stats-number">{batches.length}</p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'मास्टर QR सक्रिय' : 'Master QR active'}</span>
                  </div>
                </div>

                <div className="stats-card-rural">
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                    🌾
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'किसान स्रोत' : 'Source Harvests'}</h4>
                    <p className="stats-number">{harvests.length}</p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'UP एवं राजस्थान किसान' : 'Contributing farmers'}</span>
                  </div>
                </div>

                <div className="stats-card-rural">
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
                    ⚖️
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'कुल संकलित मात्रा' : 'Procurement Volume'}</h4>
                    <p className="stats-number">{totalVolume} kg</p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'कच्ची शहद का स्टॉक' : 'Raw stock processed'}</span>
                  </div>
                </div>

                <div className="stats-card-rural">
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
                    🛡️
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'ब्लॉकचेन लेजर' : 'Blockchain Ledger'}</h4>
                    <p className="stats-status-text" style={{ color: 'var(--color-secondary-dark)' }}>
                      🟢 TAMPER-EVIDENT
                    </p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'सुरक्षित लेजर' : 'Zero alterations'}</span>
                  </div>
                </div>
              </div>

              {/* Batches Table */}
              <div className="table-card" style={{ marginTop: '2rem' }}>
                <div className="table-card-header">
                  <h3 style={{ fontSize: '1.25rem', fontWeight: 800 }}>
                    {primaryLang === 'hi' ? 'वाणिज्यिक उत्पाद बैच (Commercial Batches)' : 'Commercial Product Batches'}
                  </h3>
                  <button className="btn btn-primary btn-sm" onClick={() => { resetBatchForm(); setActiveSubTab('create-batch'); }}>
                    <PlusCircle size={16} /> {primaryLang === 'hi' ? 'नया बैच बनाएं' : 'Create Batch'}
                  </button>
                </div>

                <div className="table-responsive">
                  <table className="custom-table">
                    <thead>
                      <tr>
                        <th>{primaryLang === 'hi' ? 'मास्टर बैच आईडी' : 'Batch ID'}</th>
                        <th>{primaryLang === 'hi' ? 'उत्पाद का नाम' : 'Product Name'}</th>
                        <th>{primaryLang === 'hi' ? 'स्रोत किसान' : 'Source Farmers'}</th>
                        <th>{primaryLang === 'hi' ? 'मात्रा' : 'Quantity'}</th>
                        <th>{primaryLang === 'hi' ? 'तारीख' : 'Created Date'}</th>
                        <th>{primaryLang === 'hi' ? 'QR कोड' : 'Master QR'}</th>
                        <th>{primaryLang === 'hi' ? 'सत्यापन' : 'Action'}</th>
                      </tr>
                    </thead>
                    <tbody>
                      {batches.map(b => (
                        <tr key={b.batchId}>
                          <td>
                            <strong style={{ fontFamily: 'monospace', color: 'var(--color-primary-dark)', fontSize: '0.95rem' }}>
                              {b.batchId}
                            </strong>
                          </td>
                          <td>
                            <strong>{b.productName}</strong>
                          </td>
                          <td>
                            <span className="badge-active" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                              👥 {b.sourceHarvestIds?.length || 2} Harvests
                            </span>
                          </td>
                          <td>{b.batchQuantity}</td>
                          <td>{b.createdDate}</td>
                          <td>
                            <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 700 }}>
                              🟢 ✓ Master QR Ready
                            </span>
                          </td>
                          <td>
                            <button 
                              className="btn btn-outline-green btn-sm"
                              onClick={() => {
                                setActiveTraceId(b.batchId);
                                setView('consumer-trace');
                              }}
                            >
                              <QrCode size={14} /> {primaryLang === 'hi' ? 'उपभोक्ता जाँच' : 'Verify'}
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}

          {/* TAB 2: CREATE BATCH WIZARD */}
          {activeSubTab === 'create-batch' && (
            <div className="wizard-card-container" style={{ maxWidth: '820px' }}>
              <div className="wizard-header">
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                  <h2 style={{ fontSize: '1.4rem', fontWeight: 800, margin: 0 }}>
                    {currentStep === 1 && (primaryLang === 'hi' ? 'चरण 1: कच्ची शहद स्रोत चुनें (Multi-Select Harvests)' : 'Step 1: Select Source Harvests')}
                    {currentStep === 2 && (primaryLang === 'hi' ? 'चरण 2: बैच विवरण व मात्रा' : 'Step 2: Batch Details & Packaging')}
                    {currentStep === 3 && (primaryLang === 'hi' ? 'चरण 3: लैब प्रमाण व सत्यापन' : 'Step 3: Lab Analysis & Blending')}
                    {currentStep === 4 && (primaryLang === 'hi' ? 'चरण 4: मास्टर QR कोड निर्माण' : 'Step 4: Master QR Code')}
                  </h2>
                  <SpeakerButton 
                    text={primaryLang === 'hi'
                      ? "कच्ची शहद का स्रोत चुनें। आप अलग-अलग किसानों से प्राप्त शहद को एक साथ चुनकर ब्लेंड कर सकते हैं।"
                      : "Select source harvests. Check multiple contributing farmer lots to preserve complete provenance trail."}
                    lang={primaryLang}
                    size={20}
                  />
                </div>

                <div className="wizard-dots-row">
                  {[1, 2, 3, 4].map(s => (
                    <div key={s} className={`wizard-dot ${currentStep === s ? 'active' : currentStep > s ? 'completed' : ''}`}>
                      {currentStep > s ? '✓' : s}
                    </div>
                  ))}
                </div>
              </div>

              {/* STEP 1: Multi-Select Harvests */}
              {currentStep === 1 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem', flexWrap: 'wrap', gap: '0.5rem' }}>
                      <p style={{ color: 'var(--color-text-muted)', fontSize: '0.95rem', margin: 0 }}>
                        {primaryLang === 'hi'
                          ? 'जिन कच्ची शहद बैचों को मिलाकर यह उत्पाद बनाया जा रहा है, उन्हें चुनें:'
                          : 'Select raw farmer harvests contributing to this commercial blend:'}
                      </p>

                      <div className="provenance-counter-badge">
                        ✨ {primaryLang === 'hi' 
                          ? `${selectedHarvestIds.length} शहद बैच चयनित (${uniqueBeekeepers} किसानों से)` 
                          : `${selectedHarvestIds.length} Harvests Added`}
                      </div>
                    </div>

<div style={{ marginTop: '1rem' }}>

  {/* Harvest ID Input */}
  <div style={{ display: 'flex', gap: '0.75rem', alignItems: 'stretch' }}>

    <input
      type="text"
      className="form-input"
      placeholder="Enter Harvest ID (e.g. HB-BK0001-20260820-01)"
      value={harvestIdInput}
      onChange={(e) => {
        setHarvestIdInput(e.target.value);
        setHarvestIdError('');
      }}
      onKeyDown={(e) => {
        if (e.key === 'Enter') {
          e.preventDefault();
          addHarvestId();
        }
      }}
      style={{
        height: '52px',
        fontFamily: 'monospace',
        flex: 1
      }}
    />

    <button
      type="button"
      className="btn btn-green"
      onClick={addHarvestId}
      style={{ minWidth: '150px' }}
    >
      + Add Harvest
    </button>

  </div>

  {/* Error */}
  {harvestIdError && (
    <div
      style={{
        marginTop: '0.75rem',
        padding: '0.75rem',
        backgroundColor: '#FEF2F2',
        color: '#B91C1C',
        borderRadius: '8px',
        fontSize: '0.9rem',
        fontWeight: 600
      }}
    >
      ⚠️ {harvestIdError}
    </div>
  )}

  {/* Added Harvest IDs */}
  <div style={{ marginTop: '1.5rem' }}>

    <h4 style={{
      marginBottom: '0.75rem',
      fontSize: '1rem',
      fontWeight: 800
    }}>
      Added Harvest IDs
    </h4>

    {selectedHarvestIds.length === 0 ? (

      <div
        style={{
          padding: '1.5rem',
          textAlign: 'center',
          border: '1px dashed var(--color-border)',
          borderRadius: '10px',
          color: 'var(--color-text-muted)',
          backgroundColor: '#FDFBF7'
        }}
      >
        No Harvest IDs added yet.
        <br />
        Enter a Harvest ID above to add it.
      </div>

    ) : (

      <div style={{
        display: 'flex',
        flexDirection: 'column',
        gap: '0.6rem'
      }}>

        {selectedHarvestIds.map((id) => (

          <div
            key={id}
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              padding: '0.85rem 1rem',
              backgroundColor: '#F0FDF4',
              border: '1px solid #BBF7D0',
              borderRadius: '8px'
            }}
          >

            <div>
              <span style={{
                fontSize: '0.75rem',
                color: '#15803D',
                fontWeight: 700
              }}>
                ✓ VERIFIED HARVEST
              </span>

              <div style={{
                fontFamily: 'monospace',
                fontWeight: 700,
                marginTop: '0.2rem'
              }}>
                {id}
              </div>
            </div>

            <button
              type="button"
              onClick={() => {
                setSelectedHarvestIds(
                  prev => prev.filter(hid => hid !== id)
                );
              }}
              style={{
                border: 'none',
                background: 'transparent',
                color: '#B91C1C',
                cursor: 'pointer',
                fontWeight: 800,
                fontSize: '1.1rem'
              }}
              title="Remove Harvest ID"
            >
              ✕
            </button>

          </div>

        ))}

      </div>

    )}

  </div>

</div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setActiveSubTab('overview')}>
                      {primaryLang === 'hi' ? 'रद्द करें' : 'Cancel'}
                    </button>
                    <button 
                      className="btn btn-green btn-wizard-next" 
                      onClick={() => {
                     if (selectedHarvestIds.length === 0) {
                     alert("Please enter at least one valid Harvest ID.");
                     return;
}                        setCurrentStep(2);
                      }}
                    >
                      <span>{primaryLang === 'hi' ? 'बैच विवरण दर्ज करें (Next)' : 'Continue to Batch Info'}</span>
                      <ArrowRight size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* STEP 2: Batch Details */}
              {currentStep === 2 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <div className="form-group">
                      <label className="form-label" htmlFor="product-name-input">
                        {primaryLang === 'hi' ? 'उत्पाद का नाम (Product Label Name):' : 'Product Label Name:'}
                      </label>
                      <input 
                        id="product-name-input"
                        type="text" 
                        className="form-input" 
                        value={productName}
                        onChange={(e) => setProductName(e.target.value)}
                        style={{ height: '52px', fontSize: '1.05rem', fontWeight: 600 }}
                        required
                      />
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="batch-quantity-input">
                        {primaryLang === 'hi' ? 'कुल बैच मात्रा एवं जार संख्या:' : 'Total Batch Quantity & Jar Count:'}
                      </label>
                      <input 
                        id="batch-quantity-input"
                        type="text" 
                        className="form-input" 
                        placeholder="e.g. 500 kg (1,000 Jars of 500g)"
                        value={batchQuantity}
                        onChange={(e) => setBatchQuantity(e.target.value)}
                        style={{ height: '52px' }}
                        required
                      />
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="processing-notes-input">
                        {primaryLang === 'hi' ? 'प्रसंस्करण व छनाई विवरण (Processing Information):' : 'Processing & Filtration Details:'}
                      </label>
                      <textarea 
                        id="processing-notes-input"
                        className="form-input" 
                        rows="3" 
                        value={processingInfo}
                        onChange={(e) => setProcessingInfo(e.target.value)}
                      ></textarea>
                    </div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setCurrentStep(1)}>
                      <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'पीछे' : 'Back'}
                    </button>
                    <button className="btn btn-green btn-wizard-next" onClick={() => setCurrentStep(3)}>
                      <span>{primaryLang === 'hi' ? 'लैब जाँच जोड़ें (Next)' : 'Next to Lab Test'}</span>
                      <ArrowRight size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* STEP 3: Lab Analysis Verification */}
              {currentStep === 3 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <div className="form-group">
                      <label className="form-label" htmlFor="company-lab-select">
                        {primaryLang === 'hi' ? 'मान्यता प्राप्त टेस्टिंग लैब:' : 'Accredited Testing Laboratory:'}
                      </label>
                      <select 
                        id="company-lab-select"
                        className="form-input"
                        value={labName}
                        onChange={(e) => setLabName(e.target.value)}
                        style={{ height: '52px' }}
                      >
                        <option value="Demo Honey Testing Laboratory (NABL #104)">Demo Honey Testing Laboratory (NABL #104)</option>
                        <option value="National Honey Analytics & Purity Center">National Honey Analytics & Purity Center</option>
                      </select>
                    </div>

                    <div className="form-group">
                      <label className="form-label">
                        {primaryLang === 'hi' ? 'मास्टर बैच लैब रिपोर्ट (PDF):' : 'Master Batch Analysis Certificate:'}
                      </label>
                      <div 
                        className="file-upload-box-wizard" 
                        onClick={() => document.getElementById('batch-pdf-upload')?.click()}
                        style={{ minHeight: '64px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.6rem', border: '2px dashed var(--color-border)', borderRadius: 'var(--radius-md)', cursor: 'pointer', padding: '0.5rem 1rem', backgroundColor: '#FDFBF7' }}
                      >
                        <Upload size={20} style={{ color: 'var(--color-primary-dark)' }} />
                        <span style={{ fontSize: '0.88rem', fontWeight: 600 }}>
                          {labReportFile ? `${labReportFile.name} (Attached)` : "Click to select Batch Lab PDF Report"}
                        </span>
                      </div>
                      <input 
                        id="batch-pdf-upload"
                        type="file" 
                        accept=".pdf" 
                        style={{ display: 'none' }}
                        onChange={(e) => { if(e.target.files?.[0]) setLabReportFile(e.target.files[0]); }}
                      />
                    </div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setCurrentStep(2)}>
                      <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'पीछे' : 'Back'}
                    </button>
                    <button className="btn btn-green btn-wizard-next" onClick={handleCreateBatch}>
                      <span>{primaryLang === 'hi' ? 'ब्लॉकचेन बैच व Master QR बनाएं' : 'Commit Batch to Ledger'}</span>
                      <Sparkles size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* STEP 4: Output Screen */}
              {currentStep === 4 && (
                <div className="wizard-body">
                  {verificationStep < 4 ? (
                    <div style={{ padding: '2rem', textAlign: 'center' }}>
                      <h3 style={{ fontSize: '1.4rem', marginBottom: '1.5rem', fontWeight: 800 }}>
                        {primaryLang === 'hi' ? 'मास्टर बैच ब्लॉकचेन सत्यापन प्रगति...' : 'Committing Master Batch to Blockchain...'}
                      </h3>
                      <div className="flow-circle active pulse-icon" style={{ margin: '0 auto 2rem auto', width: '4rem', height: '4rem', fontSize: '1.5rem' }}>
                        🏭
                      </div>

                      <ul className="rural-progress-list">
                        <li className={`rural-progress-item ${verificationStep >= 1 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 1 ? '✓' : '1'}</span>
                          <span>FSSAI License ({user.licenseNumber}) Verified...</span>
                        </li>
                        <li className={`rural-progress-item ${verificationStep >= 2 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 2 ? '✓' : '2'}</span>
                          <span>Linking {selectedHarvestIds.length} raw farmer harvest hashes...</span>
                        </li>
                        <li className={`rural-progress-item ${verificationStep >= 3 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 3 ? '✓' : '3'}</span>
                          <span>Generating Master Bottle QR Matrix...</span>
                        </li>
                      </ul>
                    </div>
                  ) : (
                    <div className="success-output-screen">
                      <div className="success-icon-badge" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
                        <Check size={36} />
                      </div>

                      <h2 style={{ fontSize: '1.8rem', fontWeight: 900, color: 'var(--color-secondary-dark)' }}>
                        {primaryLang === 'hi' ? 'मास्टर बैच सफलतापूर्वक तैयार!' : 'Commercial Batch Created!'}
                      </h2>
                      <p style={{ color: 'var(--color-text-muted)', fontSize: '0.95rem', marginBottom: '1.75rem' }}>
                        {primaryLang === 'hi' ? 'बोतल लेबलों के लिए मास्टर QR कोड तैयार है:' : 'Master QR code for jar labels is ready for retail packaging:'}
                      </p>

                      <div className="printable-qr-card">
                        <div className="qr-card-top-tag" style={{ backgroundColor: 'var(--color-secondary-dark)' }}>
                          🏷️ HoneyChain Master Retail Label • शुद्धता गारंटी
                        </div>

                        <div className="qr-large-graphic">
                          <QrCode size={180} color="#1F2937" />
                        </div>

                        <div className="qr-details-block">
                          <div style={{ fontSize: '0.8rem', color: 'var(--color-text-light)', textTransform: 'uppercase', fontWeight: 700 }}>
                            MASTER BATCH ID
                          </div>
                          <div style={{ fontSize: '1.3rem', fontFamily: 'monospace', fontWeight: 900, color: 'var(--color-secondary-dark)' }}>
                            {createdBatchId}
                          </div>
                          <div style={{ fontSize: '1rem', fontWeight: 700, marginTop: '0.35rem' }}>
                            {productName}
                          </div>
                          <div style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>
                            {user.companyName} • {batchQuantity}
                          </div>
                        </div>

                        <button 
                          className="btn btn-green btn-print-main"
                          onClick={() => alert("Print layout generated for retail bottle labels.")}
                        >
                          <Printer size={20} />
                          <span>{primaryLang === 'hi' ? 'बोतल लेबल्स के लिए Master QR प्रिंट करें' : 'Print Master QR Labels for Jars'}</span>
                        </button>
                      </div>

                      <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', marginTop: '2rem', flexWrap: 'wrap' }}>
                        <button 
                          className="btn btn-outline-green" 
                          onClick={() => {
                            setActiveTraceId(createdBatchId);
                            setView('consumer-trace');
                          }}
                          style={{ minHeight: '52px', fontSize: '1rem', fontWeight: 700 }}
                        >
                          🔍 {primaryLang === 'hi' ? 'उपभोक्ता सत्यापन पेज देखें' : 'Test Consumer QR Page'}
                        </button>

                        <button 
                          className="btn btn-primary" 
                          onClick={() => {
                            resetBatchForm();
                            setActiveSubTab('overview');
                          }}
                          style={{ minHeight: '52px', fontSize: '1rem', fontWeight: 800 }}
                        >
                          🏠 {primaryLang === 'hi' ? 'डैशबोर्ड पर वापस' : 'Back to Dashboard'}
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
            <div>
              <h2 style={{ fontSize: '1.5rem', fontWeight: 800, marginBottom: '1.5rem' }}>
                {primaryLang === 'hi' ? 'सभी मास्टर बैच (Master Batches)' : 'All Master Batches'}
              </h2>

              <div className="harvest-cards-grid">
                {batches.map(b => (
                  <div key={b.batchId} className="harvest-card-box">
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.75rem' }}>
                      <div>
                        <span style={{ fontSize: '0.75rem', textTransform: 'uppercase', color: 'var(--color-text-light)', fontWeight: 700 }}>
                          BATCH ID
                        </span>
                        <h3 style={{ fontFamily: 'monospace', color: 'var(--color-secondary-dark)', fontSize: '1.15rem' }}>
                          {b.batchId}
                        </h3>
                      </div>
                      <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 800 }}>
                        🟢 Active Master QR
                      </span>
                    </div>

                    <h4 style={{ fontSize: '1.05rem', fontWeight: 700, margin: '0.5rem 0' }}>{b.productName}</h4>
                    <p style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)', marginBottom: '1rem' }}>
                      {b.processingInfo}
                    </p>

                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '1px dashed var(--color-border)', paddingTop: '0.75rem' }}>
                      <span style={{ fontSize: '0.82rem', fontWeight: 600 }}>
                        📦 {b.batchQuantity}
                      </span>
                      <button 
                        className="btn btn-outline-green btn-sm"
                        onClick={() => {
                          setActiveTraceId(b.batchId);
                          setView('consumer-trace');
                        }}
                      >
                        <QrCode size={14} /> {primaryLang === 'hi' ? 'जाँचें' : 'Trace'}
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

        </div>
      </main>
    </div>
  );
}
