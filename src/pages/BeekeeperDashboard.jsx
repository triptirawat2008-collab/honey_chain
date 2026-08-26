import React, { useState } from 'react';
import { 
  Hexagon, LayoutDashboard, PlusCircle, Compass, Clipboard, 
  Bell, History, LogOut, ShieldCheck, MapPin, Layers, 
  Activity, Check, FileText, Upload, Calendar, X
} from 'lucide-react';
import { generateMockHash } from '../data/mockData';

export default function BeekeeperDashboard({ 
  user, setView, harvests, setHarvests, apiaries, setApiaries, 
  healthLogs, setHealthLogs, reminders, setReminders, history, setHistory,
  setActiveTraceId
}) {
  const [activeSubTab, setActiveSubTab] = useState('overview'); // overview, create-harvest, apiaries, health, reminders, history
  
  // Create Harvest State
  const [selectedApiaryId, setSelectedApiaryId] = useState(apiaries[0]?.locationId || '');
  const [harvestDate, setHarvestDate] = useState('2026-08-26');
  const [selectedFlowers, setSelectedFlowers] = useState([]);
  const [customFlower, setCustomFlower] = useState('');
  const [labName, setLabName] = useState('Demo Honey Testing Laboratory');
  const [labReportFile, setLabReportFile] = useState(null);
  
  // Verification progress simulation
  const [verificationStep, setVerificationStep] = useState(0); // 0: idle, 1: verifying id, 2: verifying lab, 3: verifying report, 4: done
  const [createdHarvestId, setCreatedHarvestId] = useState(null);

  // Apiary Location modal state
  const [showMoveModal, setShowMoveModal] = useState(false);
  const [activeApiaryForMove, setActiveApiaryForMove] = useState(null);
  const [moveType, setMoveType] = useState('all'); // all, some
  const [moveCount, setMoveCount] = useState(1);
  const [newGps, setNewGps] = useState('');
  const [newLocationName, setNewLocationName] = useState('');

  // Add Health Log state
  const [logApiaryId, setLogApiaryId] = useState(apiaries[0]?.locationId || '');
  const [logStatus, setLogStatus] = useState('Healthy');
  const [logColonies, setLogColonies] = useState(0);
  const [logNotes, setLogNotes] = useState('');

  // Add Reminder state
  const [newRemTitle, setNewRemTitle] = useState('');
  const [newRemDate, setNewRemDate] = useState('');
  const [newRemNotes, setNewRemNotes] = useState('');

  // FLOWER SOURCES
  const flowerOptions = ["Mustard", "Eucalyptus", "Acacia", "Litchi", "Sunflower", "Multifloral", "Other"];

  const handleFlowerToggle = (flower) => {
    if (flower === 'Other') {
      if (selectedFlowers.includes('Other')) {
        setSelectedFlowers(selectedFlowers.filter(f => f !== 'Other'));
      } else {
        setSelectedFlowers([...selectedFlowers, 'Other']);
      }
      return;
    }
    if (selectedFlowers.includes(flower)) {
      setSelectedFlowers(selectedFlowers.filter(f => f !== flower));
    } else {
      setSelectedFlowers([...selectedFlowers, flower]);
    }
  };

  const handleCreateHarvest = (e) => {
    e.preventDefault();
    if (selectedFlowers.length === 0) {
      alert("Please select at least one flower source.");
      return;
    }
    
    // Start verification steps animation
    setVerificationStep(1);
    
    setTimeout(() => {
      setVerificationStep(2);
      
      setTimeout(() => {
        setVerificationStep(3);
        
        setTimeout(() => {
          setVerificationStep(4);
          
          // Generate harvest ID and record
          const targetApiary = apiaries.find(a => a.locationId === selectedApiaryId);
          const hCount = harvests.filter(h => h.beekeeperId === user.beekeeperId).length + 1;
          const dateStr = harvestDate.replace(/-/g, '');
          const newHarvestId = `HB-BK${user.beekeeperId.substring(7)}-${dateStr}-0${hCount}`;
          
          const rawString = `${newHarvestId}|${user.beekeeperId}|${harvestDate}|${selectedFlowers.join(',')}`;
          const hashVal = generateMockHash(rawString);
          
          const newHarvest = {
            harvestId: newHarvestId,
            beekeeperId: user.beekeeperId,
            beekeeperName: user.registeredName,
            harvestDate: harvestDate,
            flowerSources: selectedFlowers.includes('Other') && customFlower ? [...selectedFlowers.filter(f => f !== 'Other'), customFlower] : selectedFlowers,
            locationId: selectedApiaryId,
            locationName: targetApiary ? targetApiary.name : 'Unknown Location',
            labName: labName,
            labReference: "LAB-SYN-00001",
            labReportName: labReportFile ? labReportFile.name : "lab_report_sih_demo.pdf",
            labStatus: "Verified",
            blockchainStatus: "Verified",
            hash: hashVal,
            previousHash: harvests[harvests.length - 1]?.hash || "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
            txRef: "0x" + generateMockHash(hashVal).substring(0, 60),
            timestamp: new Date().toISOString()
          };

          setHarvests([newHarvest, ...harvests]);
          setCreatedHarvestId(newHarvestId);

          // Add to history
          const newHistoryItem = {
            id: `H-${Date.now()}`,
            timestamp: new Date().toISOString(),
            type: "Harvest Created",
            details: `Created Harvest ${newHarvestId} (${newHarvest.flowerSources.join('/')}) from ${newHarvest.locationName}.`
          };
          setHistory([newHistoryItem, ...history]);

        }, 1000);
      }, 1000);
    }, 1000);
  };

  const resetHarvestForm = () => {
    setVerificationStep(0);
    setCreatedHarvestId(null);
    setSelectedFlowers([]);
    setCustomFlower('');
    setLabReportFile(null);
  };

  // Move Colonies / Update Location Logic
  const handleOpenMoveModal = (apiary) => {
    setActiveApiaryForMove(apiary);
    setMoveCount(1);
    setMoveType('all');
    setNewGps(apiary.gps);
    setNewLocationName('');
    setShowMoveModal(true);
  };

  const handleExecuteMove = () => {
    if (!newGps) {
      alert("Please provide a new GPS coordinate.");
      return;
    }

    if (moveType === 'all') {
      // Keep same location ID, update GPS and name if provided
      const updatedApiaries = apiaries.map(a => {
        if (a.locationId === activeApiaryForMove.locationId) {
          return {
            ...a,
            gps: newGps,
            name: newLocationName ? newLocationName : a.name,
            lastInspection: new Date().toISOString().split('T')[0]
          };
        }
        return a;
      });
      setApiaries(updatedApiaries);

      // Add to history
      const newHistoryItem = {
        id: `H-${Date.now()}`,
        timestamp: new Date().toISOString(),
        type: "Location Updated",
        details: `Moved ALL colonies of ${activeApiaryForMove.name} (LOC ID: ${activeApiaryForMove.locationId}) to new GPS coordinate: ${newGps}.`
      };
      setHistory([newHistoryItem, ...history]);
    } else {
      // Move some colonies: split population
      if (moveCount >= activeApiaryForMove.hiveCount) {
        alert("To move all colonies, please select the 'Move all colonies' option.");
        return;
      }

      // Create new apiary record
      const newLocId = `LOC-00${apiaries.length + 1}`;
      const newLocName = newLocationName ? newLocationName : `${activeApiaryForMove.name} (Moved Colony Group)`;
      
      const newApiary = {
        locationId: newLocId,
        name: newLocName,
        gps: newGps,
        hiveCount: parseInt(moveCount),
        status: activeApiaryForMove.status,
        lastInspection: new Date().toISOString().split('T')[0]
      };

      // Subtract count from original apiary
      const updatedApiaries = apiaries.map(a => {
        if (a.locationId === activeApiaryForMove.locationId) {
          return {
            ...a,
            hiveCount: a.hiveCount - parseInt(moveCount),
            lastInspection: new Date().toISOString().split('T')[0]
          };
        }
        return a;
      });

      setApiaries([...updatedApiaries, newApiary]);

      // Add to history
      const newHistoryItem = {
        id: `H-${Date.now()}`,
        timestamp: new Date().toISOString(),
        type: "Colonies Split",
        details: `Split ${moveCount} colonies from ${activeApiaryForMove.name} and established new Location ID: ${newLocId} at GPS: ${newGps}.`
      };
      setHistory([newHistoryItem, ...history]);
    }

    setShowMoveModal(false);
  };

  // Add Health Log Logic
  const handleAddHealthLog = (e) => {
    e.preventDefault();
    const targetApiary = apiaries.find(a => a.locationId === logApiaryId);
    if (!targetApiary) return;

    const newLog = {
      id: `HL-${Date.now()}`,
      locationId: logApiaryId,
      date: new Date().toISOString().split('T')[0],
      status: logStatus,
      affectedColonies: parseInt(logColonies),
      notes: logNotes || "Routine inspect complete."
    };

    setHealthLogs([newLog, ...healthLogs]);

    // Also update target apiary's status
    const updatedApiaries = apiaries.map(a => {
      if (a.locationId === logApiaryId) {
        return {
          ...a,
          status: logStatus,
          lastInspection: new Date().toISOString().split('T')[0]
        };
      }
      return a;
    });
    setApiaries(updatedApiaries);

    // Add to history
    const newHistoryItem = {
      id: `H-${Date.now()}`,
      timestamp: new Date().toISOString(),
      type: "Health Log Added",
      details: `Added health status log for ${targetApiary.name}: ${logStatus} (${logColonies} affected boxes).`
    };
    setHistory([newHistoryItem, ...history]);

    // Reset fields
    setLogColonies(0);
    setLogNotes('');
    alert("Health log saved successfully!");
  };

  // Add Reminder Logic
  const handleAddReminder = (e) => {
    e.preventDefault();
    if (!newRemTitle || !newRemDate) {
      alert("Please provide a title and target date.");
      return;
    }

    const newRem = {
      id: `RM-${Date.now()}`,
      title: newRemTitle,
      date: newRemDate,
      notes: newRemNotes,
      status: 'Pending'
    };

    setReminders([newRem, ...reminders]);
    setNewRemTitle('');
    setNewRemDate('');
    setNewRemNotes('');
    alert("Reminder added.");
  };

  const handleToggleReminder = (id) => {
    const updated = reminders.map(r => {
      if (r.id === id) {
        return { ...r, status: r.status === 'Pending' ? 'Completed' : 'Pending' };
      }
      return r;
    });
    setReminders(updated);
  };

  // Filter harvests for active Beekeeper
  const myHarvests = harvests.filter(h => h.beekeeperId === user.beekeeperId);
  const totalHives = apiaries.reduce((acc, curr) => acc + curr.hiveCount, 0);

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
            className={`sidebar-item ${activeSubTab === 'create-harvest' ? 'active' : ''}`}
            onClick={() => { resetHarvestForm(); setActiveSubTab('create-harvest'); }}
          >
            <PlusCircle size={18} />
            <span>Create Harvest</span>
          </li>

          <li className="sidebar-label">Beekeeping</li>
          <li 
            className={`sidebar-item ${activeSubTab === 'apiaries' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('apiaries')}
          >
            <Compass size={18} />
            <span>Apiary Locations</span>
          </li>
          <li 
            className={`sidebar-item ${activeSubTab === 'health' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('health')}
          >
            <Clipboard size={18} />
            <span>Health Logs</span>
          </li>
          <li 
            className={`sidebar-item ${activeSubTab === 'reminders' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('reminders')}
          >
            <Bell size={18} />
            <span>Reminders</span>
          </li>
          <li 
            className={`sidebar-item ${activeSubTab === 'history' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('history')}
          >
            <History size={18} />
            <span>Audit History</span>
          </li>
        </ul>

        <div className="sidebar-footer">
          <div className="sidebar-profile" style={{ marginBottom: "1rem" }}>
            <div className="sidebar-avatar">
              {user.registeredName.split(' ').map(n => n[0]).join('')}
            </div>
            <div>
              <div style={{ fontWeight: 600 }}>{user.registeredName}</div>
              <div style={{ fontSize: "0.75rem", color: "rgba(255,255,255,0.5)" }}>Beekeeper</div>
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
            <h1>Solo Beekeeper Hub</h1>
            <p>Traceability registry and hive records interface</p>
          </div>
          <div style={{ display: "flex", alignItems: "center", gap: "1rem" }}>
            <span className="badge-active" style={{ display: "inline-flex", alignItems: "center", gap: "0.25rem" }}>
              <ShieldCheck size={14} /> Official ID: {user.beekeeperId}
            </span>
          </div>
        </header>

        {/* Dynamic Content */}
        <div className="dashboard-body">
          
          {/* TAB 1: OVERVIEW */}
          {activeSubTab === 'overview' && (
            <div>
              {/* Summary Widgets */}
              <div className="stats-grid">
                <div className="stats-card">
                  <div className="stats-icon-box icon-yellow">
                    <Compass size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Apiary Sites</h4>
                    <p>{apiaries.length}</p>
                  </div>
                </div>

                <div className="stats-card">
                  <div className="stats-icon-box icon-green">
                    <Layers size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Total Colony Boxes</h4>
                    <p>{totalHives}</p>
                  </div>
                </div>

                <div className="stats-card">
                  <div className="stats-icon-box icon-purple">
                    <FileText size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>My Harvests</h4>
                    <p>{myHarvests.length}</p>
                  </div>
                </div>

                <div className="stats-card">
                  <div className="stats-icon-box icon-green" style={{ backgroundColor: "#ECFDF5", color: "#059669" }}>
                    <Activity size={24} />
                  </div>
                  <div className="stats-info">
                    <h4>Recent Health</h4>
                    <p style={{ fontSize: "1.2rem", fontWeight: 600, marginTop: "0.25rem" }}>
                      {apiaries.some(a => a.status === 'Critical') ? 'Critical Attention' : 
                       apiaries.some(a => a.status === 'Needs Attention') ? 'Needs Attention' : 'All Healthy'}
                    </p>
                  </div>
                </div>
              </div>

              {/* Table of Harvests */}
              <div className="table-card">
                <div className="table-card-header">
                  <h3>Recent Honey Harvests</h3>
                  <button className="btn btn-primary btn-sm" onClick={() => setActiveSubTab('create-harvest')}>
                    <PlusCircle size={16} /> Create Harvest
                  </button>
                </div>
                
                <div className="table-responsive">
                  <table className="custom-table">
                    <thead>
                      <tr>
                        <th>Harvest ID</th>
                        <th>Harvest Date</th>
                        <th>Flower Source</th>
                        <th>Extraction Location</th>
                        <th>Lab status</th>
                        <th>Blockchain Ledger</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      {myHarvests.length === 0 ? (
                        <tr>
                          <td colSpan="7" style={{ textAlign: "center", color: "var(--color-text-light)", padding: "2rem" }}>
                            No harvests registered yet. Click "Create Harvest" to begin.
                          </td>
                        </tr>
                      ) : (
                        myHarvests.map((h) => (
                          <tr key={h.harvestId}>
                            <td style={{ fontWeight: 600 }}>{h.harvestId}</td>
                            <td>{h.harvestDate}</td>
                            <td>
                              {h.flowerSources.map(f => (
                                <span key={f} className="badge-active" style={{ marginRight: "0.25rem", backgroundColor: "#FEF3C7", color: "#D97706" }}>
                                  {f}
                                </span>
                              ))}
                            </td>
                            <td>{h.locationName}</td>
                            <td>
                              <span className="badge-active" style={{ backgroundColor: "#D1FAE5", color: "#065F46" }}>
                                ✓ {h.labStatus}
                              </span>
                            </td>
                            <td>
                              <span className="blockchain-status-tag">
                                <ShieldCheck size={12} /> {h.blockchainStatus}
                              </span>
                            </td>
                            <td>
                              <button 
                                className="btn btn-secondary btn-sm"
                                onClick={() => {
                                  setActiveTraceId(h.harvestId);
                                  setView('consumer-trace');
                                }}
                              >
                                Trace
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

          {/* TAB 2: CREATE HARVEST */}
          {activeSubTab === 'create-harvest' && (
            <div className="form-card">
              <h2 style={{ marginBottom: "0.5rem" }}>Create New Honey Harvest</h2>
              <p style={{ color: "var(--color-text-muted)", fontSize: "0.9rem", marginBottom: "2rem" }}>
                Log a fresh honey harvest extraction. This record will be verified against lab data and secured on the blockchain ledger.
              </p>

              {verificationStep === 0 ? (
                <form onSubmit={handleCreateHarvest}>
                  <div className="form-grid-2">
                    <div className="form-group">
                      <label className="form-label">Registered Beekeeper</label>
                      <input type="text" className="form-input" value={user.registeredName} disabled style={{ backgroundColor: "#F3F4F6", cursor: "not-allowed" }} />
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="apiary-select">Extraction Location (Apiary)</label>
                      <select 
                        id="apiary-select"
                        className="form-input" 
                        value={selectedApiaryId}
                        onChange={(e) => setSelectedApiaryId(e.target.value)}
                      >
                        {apiaries.map(a => (
                          <option key={a.locationId} value={a.locationId}>
                            {a.name} ({a.hiveCount} Hives - GPS: {a.gps})
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>

                  <div className="form-grid-2">
                    <div className="form-group">
                      <label className="form-label" htmlFor="harvest-date-input">Harvest Date</label>
                      <input 
                        id="harvest-date-input"
                        type="date" 
                        className="form-input" 
                        value={harvestDate}
                        onChange={(e) => setHarvestDate(e.target.value)}
                        required
                      />
                    </div>

                    <div className="form-group">
                      <label className="form-label">Flower Source(s) (Select multiple)</label>
                      <div className="chips-container">
                        {flowerOptions.map(flower => (
                          <span 
                            key={flower}
                            className={`chip ${selectedFlowers.includes(flower) ? 'active' : ''}`}
                            onClick={() => handleFlowerToggle(flower)}
                          >
                            {flower}
                          </span>
                        ))}
                      </div>
                      {selectedFlowers.includes('Other') && (
                        <input 
                          type="text" 
                          className="form-input" 
                          placeholder="Specify other flower source..."
                          value={customFlower}
                          onChange={(e) => setCustomFlower(e.target.value)}
                          style={{ marginTop: "0.5rem" }}
                          required
                        />
                      )}
                    </div>
                  </div>

                  <div style={{ borderTop: "1px dashed var(--color-border)", margin: "1.5rem 0", paddingTop: "1.5rem" }}>
                    <h4 style={{ fontSize: "0.95rem", marginBottom: "1rem" }}>Laboratory Analysis Verification</h4>
                    
                    <div className="form-grid-2">
                      <div className="form-group">
                        <label className="form-label" htmlFor="lab-name-select">Authorized Testing Laboratory</label>
                        <select 
                          id="lab-name-select"
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
                        <label className="form-label" htmlFor="lab-report-upload">Simulate Lab Report PDF</label>
                        <div className="file-upload-box" onClick={() => document.getElementById('lab-report-upload')?.click()}>
                          <Upload size={18} className="file-upload-icon" />
                          <div className="file-upload-text">
                            {labReportFile ? (
                              <strong style={{ color: "var(--color-secondary)" }}>{labReportFile.name} (Attached)</strong>
                            ) : "Click to select PDF report"}
                          </div>
                        </div>
                        <input 
                          id="lab-report-upload"
                          type="file" 
                          accept=".pdf" 
                          style={{ display: "none" }}
                          onChange={(e) => { if(e.target.files?.[0]) setLabReportFile(e.target.files[0]); }}
                        />
                      </div>
                    </div>
                  </div>

                  <button type="submit" className="btn btn-primary" style={{ width: "100%", marginTop: "1.5rem" }}>
                    Verify & Create Harvest Record
                  </button>
                </form>
              ) : verificationStep < 4 ? (
                <div>
                  <h3 style={{ textAlign: "center", marginBottom: "1.5rem" }}>Verifying Harvest Credentials</h3>
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
                      <span>Verifying Beekeeper Identity Registry Status...</span>
                    </li>
                    <li className={`progress-item ${verificationStep >= 2 ? 'completed' : ''}`}>
                      <span className={`progress-bullet ${verificationStep >= 2 ? 'bullet-success' : 'bullet-pending'}`}>
                        {verificationStep >= 2 ? '✓' : '2'}
                      </span>
                      <span>Verifying Lab Registration Credentials...</span>
                    </li>
                    <li className={`progress-item ${verificationStep >= 3 ? 'completed' : ''}`}>
                      <span className={`progress-bullet ${verificationStep >= 3 ? 'bullet-success' : 'bullet-pending'}`}>
                        {verificationStep >= 3 ? '✓' : '3'}
                      </span>
                      <span>Analyzing PDF Report Hash and Integrity...</span>
                    </li>
                    <li className="progress-item">
                      <span className="progress-bullet bullet-pending">4</span>
                      <span>Commiting record hash block to HoneyChain ledger...</span>
                    </li>
                  </ul>
                </div>
              ) : (
                <div className="success-screen">
                  <div className="success-icon-wrapper">
                    <Check size={32} />
                  </div>
                  <h3 className="success-title">Harvest Created Successfully</h3>
                  <p style={{ fontSize: "0.85rem", color: "var(--color-text-muted)", marginBottom: "1.5rem" }}>
                    Record committed to blockchain reference ledger: <br />
                    <code style={{ fontSize: "0.8rem", color: "var(--color-accent-dark)" }}>{createdHarvestId}</code>
                  </p>

                  <div className="qr-preview-box">
                    <div className="qr-code-placeholder"></div>
                    <div style={{ fontSize: "0.8rem", fontWeight: 700 }}>{createdHarvestId}</div>
                    <button className="btn btn-secondary btn-sm" onClick={() => alert("Simulated print sequence initiated. QR labels can now be affixed to honey storage canisters.")}>
                      Download / Print QR Code
                    </button>
                  </div>

                  <div style={{ display: "flex", gap: "1rem", justifyContent: "center" }}>
                    <button className="btn btn-secondary" onClick={resetHarvestForm}>
                      Create Another
                    </button>
                    <button 
                      className="btn btn-primary" 
                      onClick={() => {
                        setActiveTraceId(createdHarvestId);
                        setView('consumer-trace');
                      }}
                    >
                      View Traceability Page
                    </button>
                    <button className="btn btn-outline-green" onClick={() => setActiveSubTab('overview')}>
                      View Harvest List
                    </button>
                  </div>
                </div>
              )}
            </div>
          )}

          {/* TAB 3: APIARY LOCATIONS */}
          {activeSubTab === 'apiaries' && (
            <div>
              <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "1.5rem" }}>
                <h2>My Apiary Sites</h2>
                <button className="btn btn-primary" onClick={() => {
                  const newLocId = `LOC-00${apiaries.length + 1}`;
                  const name = prompt("Enter Apiary Name:", `Apiary ${apiaries.length + 1}`);
                  const gps = prompt("Enter GPS Coordinates (latitude, longitude):", "28.7041, 77.1025");
                  const count = prompt("Enter Initial Colony Box Count:", "5");
                  
                  if (name && gps && count) {
                    const newAp = {
                      locationId: newLocId,
                      name: name,
                      gps: gps,
                      hiveCount: parseInt(count),
                      status: "Healthy",
                      lastInspection: new Date().toISOString().split('T')[0]
                    };
                    setApiaries([...apiaries, newAp]);
                    
                    const newHistoryItem = {
                      id: `H-${Date.now()}`,
                      timestamp: new Date().toISOString(),
                      type: "Location Created",
                      details: `Established new Apiary Site: ${name} (LOC ID: ${newLocId}) with ${count} colonies.`
                    };
                    setHistory([newHistoryItem, ...history]);
                  }
                }}>
                  <PlusCircle size={16} /> New Location
                </button>
              </div>

              <div className="apiary-grid">
                {apiaries.map(ap => (
                  <div key={ap.locationId} className="apiary-card">
                    <div className="apiary-card-header">
                      <div>
                        <h3>{ap.name}</h3>
                        <span style={{ fontSize: "0.75rem", color: "var(--color-text-light)" }}>ID: {ap.locationId}</span>
                      </div>
                      <span className={`badge-active ${
                        ap.status === 'Healthy' ? 'status-healthy' : 
                        ap.status === 'Needs Attention' ? 'badge-expired' : 'badge-suspended'
                      }`} style={{
                        backgroundColor: ap.status === 'Healthy' ? 'var(--color-success-light)' : 
                                         ap.status === 'Needs Attention' ? 'var(--color-warning-light)' : 'var(--color-danger-light)',
                        color: ap.status === 'Healthy' ? 'var(--color-secondary-dark)' : 
                               ap.status === 'Needs Attention' ? 'var(--color-primary-dark)' : 'var(--color-danger)'
                      }}>
                        {ap.status}
                      </span>
                    </div>

                    <div className="apiary-card-detail">
                      <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                        <MapPin size={14} /> <span>GPS Coordinate: {ap.gps}</span>
                      </div>
                      <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                        <Layers size={14} /> <span>Colonies / Boxes: {ap.hiveCount} units</span>
                      </div>
                      <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                        <Calendar size={14} /> <span>Last Inspected: {ap.lastInspection}</span>
                      </div>
                    </div>

                    <div className="apiary-actions">
                      <button className="btn btn-secondary btn-sm" onClick={() => {
                        setSelectedApiaryId(ap.locationId);
                        setLogApiaryId(ap.locationId);
                        setActiveSubTab('health');
                      }}>
                        Log Health
                      </button>
                      <button className="btn btn-outline-green btn-sm" onClick={() => handleOpenMoveModal(ap)}>
                        Move / Split Colonies
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* TAB 4: HEALTH LOGS */}
          {activeSubTab === 'health' && (
            <div style={{ display: "grid", gridTemplateColumns: "1fr 1.5fr", gap: "2rem" }}>
              {/* Form Card */}
              <div className="form-card" style={{ margin: 0, height: "fit-content" }}>
                <h3 style={{ marginBottom: "1.25rem" }}>Add Inspection Health Log</h3>
                
                <form onSubmit={handleAddHealthLog}>
                  <div className="form-group">
                    <label className="form-label" htmlFor="health-apiary-select">Target Apiary Site</label>
                    <select 
                      id="health-apiary-select"
                      className="form-input"
                      value={logApiaryId}
                      onChange={(e) => setLogApiaryId(e.target.value)}
                    >
                      {apiaries.map(a => (
                        <option key={a.locationId} value={a.locationId}>{a.name}</option>
                      ))}
                    </select>
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="health-status-select">Hive Health Status</label>
                    <select 
                      id="health-status-select"
                      className="form-input"
                      value={logStatus}
                      onChange={(e) => setLogStatus(e.target.value)}
                    >
                      <option value="Healthy">Healthy</option>
                      <option value="Needs Attention">Needs Attention</option>
                      <option value="Critical">Critical</option>
                    </select>
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="affected-colonies-input">Affected Colony Count (Box count)</label>
                    <input 
                      id="affected-colonies-input"
                      type="number" 
                      className="form-input" 
                      min="0"
                      value={logColonies}
                      onChange={(e) => setLogColonies(e.target.value)}
                      required
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="health-notes-textarea">Inspection Notes</label>
                    <textarea 
                      id="health-notes-textarea"
                      className="form-input" 
                      rows="4" 
                      placeholder="Specify observation notes: e.g. Pest activity observed, queen cell found, feeding required..."
                      value={logNotes}
                      onChange={(e) => setLogNotes(e.target.value)}
                    ></textarea>
                  </div>

                  <button type="submit" className="btn btn-primary" style={{ width: "100%" }}>
                    Save Health Log
                  </button>
                </form>

                <div className="disclaimer-box" style={{ marginTop: "1rem" }}>
                  <strong>Manual Reporting Notice:</strong> Health statuses and pest warnings are logged manually based on beekeeper physical inspections. Automated hive disease detection and sensor systems are not integrated.
                </div>
              </div>

              {/* Log Timeline view */}
              <div className="table-card" style={{ padding: "1.5rem" }}>
                <h3 style={{ marginBottom: "1rem" }}>Apiary Health Timeline</h3>
                
                <div className="log-timeline">
                  {healthLogs.length === 0 ? (
                    <div style={{ color: "var(--color-text-light)", textAlign: "center", padding: "2rem" }}>
                      No inspection health logs recorded.
                    </div>
                  ) : (
                    healthLogs.map(log => {
                      const apiary = apiaries.find(a => a.locationId === log.locationId);
                      return (
                        <div key={log.id} className={`log-item ${
                          log.status === 'Healthy' ? 'status-healthy' : 
                          log.status === 'Needs Attention' ? 'status-needs-attention' : 'status-critical'
                        }`}>
                          <div className="log-meta">
                            <span style={{ fontWeight: 700, color: "var(--color-text-main)" }}>
                              {apiary ? apiary.name : 'Unknown Apiary'}
                            </span>
                            <span>{log.date}</span>
                          </div>
                          <div style={{ fontSize: "0.8rem", marginBottom: "0.25rem" }}>
                            Status: <span style={{ fontWeight: 600 }}>{log.status}</span> 
                            {log.affectedColonies > 0 && ` (${log.affectedColonies} affected units)`}
                          </div>
                          <p className="log-notes">{log.notes}</p>
                        </div>
                      );
                    })
                  )}
                </div>
              </div>
            </div>
          )}

          {/* TAB 5: REMINDERS */}
          {activeSubTab === 'reminders' && (
            <div style={{ display: "grid", gridTemplateColumns: "1fr 1.5fr", gap: "2rem" }}>
              {/* Form */}
              <div className="form-card" style={{ margin: 0, height: "fit-content" }}>
                <h3 style={{ marginBottom: "1.25rem" }}>Set Hive Task Reminder</h3>
                <form onSubmit={handleAddReminder}>
                  <div className="form-group">
                    <label className="form-label" htmlFor="reminder-title-input">Task Title</label>
                    <input 
                      id="reminder-title-input"
                      type="text" 
                      className="form-input" 
                      placeholder="e.g. Inspect wasp traps, Honey extraction"
                      value={newRemTitle}
                      onChange={(e) => setNewRemTitle(e.target.value)}
                      required
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="reminder-date-input">Target Date</label>
                    <input 
                      id="reminder-date-input"
                      type="date" 
                      className="form-input" 
                      value={newRemDate}
                      onChange={(e) => setNewRemDate(e.target.value)}
                      required
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="reminder-notes-textarea">Notes</label>
                    <textarea 
                      id="reminder-notes-textarea"
                      className="form-input" 
                      placeholder="Additional notes or action steps..."
                      value={newRemNotes}
                      onChange={(e) => setNewRemNotes(e.target.value)}
                    ></textarea>
                  </div>

                  <button type="submit" className="btn btn-primary" style={{ width: "100%" }}>
                    Create Reminder
                  </button>
                </form>
              </div>

              {/* Reminders List */}
              <div className="table-card" style={{ padding: "1.5rem" }}>
                <h3 style={{ marginBottom: "1rem" }}>Scheduled Reminders</h3>

                <div style={{ display: "flex", flexDirection: "column", gap: "1rem" }}>
                  {reminders.length === 0 ? (
                    <div style={{ color: "var(--color-text-light)", textAlign: "center", padding: "2rem" }}>
                      No tasks scheduled.
                    </div>
                  ) : (
                    reminders.map(rem => (
                      <div key={rem.id} className="verify-results" style={{ 
                        margin: 0, 
                        borderStyle: "solid",
                        backgroundColor: rem.status === 'Completed' ? '#F9FAFB' : '#FEFDF9',
                        opacity: rem.status === 'Completed' ? 0.7 : 1
                      }}>
                        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start", marginBottom: "0.5rem" }}>
                          <span style={{ 
                            fontWeight: 700, 
                            fontSize: "0.95rem",
                            textDecoration: rem.status === 'Completed' ? 'line-through' : 'none'
                          }}>
                            {rem.title}
                          </span>
                          <span style={{ fontSize: "0.75rem", color: "var(--color-text-light)" }}>
                            Due: {rem.date}
                          </span>
                        </div>
                        <p style={{ fontSize: "0.85rem", color: "var(--color-text-muted)", marginBottom: "0.75rem" }}>
                          {rem.notes}
                        </p>
                        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                          <span className={rem.status === 'Completed' ? 'badge-active' : 'badge-expired'} style={{
                            backgroundColor: rem.status === 'Completed' ? 'var(--color-success-light)' : 'var(--color-warning-light)',
                            color: rem.status === 'Completed' ? 'var(--color-secondary-dark)' : 'var(--color-primary-dark)'
                          }}>
                            {rem.status}
                          </span>
                          <button 
                            className="btn btn-secondary btn-sm" 
                            onClick={() => handleToggleReminder(rem.id)}
                            style={{ padding: "0.2rem 0.5rem", fontSize: "0.75rem" }}
                          >
                            Mark as {rem.status === 'Pending' ? 'Completed' : 'Pending'}
                          </button>
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </div>
            </div>
          )}

          {/* TAB 6: AUDIT HISTORY */}
          {activeSubTab === 'history' && (
            <div>
              <h2 style={{ marginBottom: "1.5rem" }}>Audit Logs Timeline</h2>
              <div className="history-list">
                {history.length === 0 ? (
                  <div style={{ color: "var(--color-text-light)", textAlign: "center", padding: "2rem" }}>
                    No operations logged yet.
                  </div>
                ) : (
                  history.map(item => (
                    <div key={item.id} className="history-item">
                      <div className="history-time">
                        {new Date(item.timestamp).toLocaleString()}
                      </div>
                      <div className="history-info">
                        <div className="history-type">{item.type}</div>
                        <div className="history-desc">{item.details}</div>
                      </div>
                    </div>
                  ))
                )}
              </div>
            </div>
          )}

        </div>
      </main>

      {/* MOVE COLONIES SPLIT MODAL */}
      {showMoveModal && activeApiaryForMove && (
        <div className="modal-overlay">
          <div className="modal-content">
            <div className="modal-header">
              <h3>Move/Split Colony Group</h3>
              <button style={{ background: "none", border: "none", cursor: "pointer" }} onClick={() => setShowMoveModal(false)}>
                <X size={18} />
              </button>
            </div>

            <div className="form-group">
              <label className="form-label">Active Apiary: <strong>{activeApiaryForMove.name}</strong></label>
              <div style={{ fontSize: "0.85rem", color: "var(--color-text-muted)" }}>
                Contains {activeApiaryForMove.hiveCount} total colony boxes.
              </div>
            </div>

            <div className="form-group">
              <label className="form-label">Movement Type</label>
              <div style={{ display: "flex", gap: "1rem", marginTop: "0.25rem" }}>
                <label className="tamper-toggle-label" style={{ color: "var(--color-text-main)", fontSize: "0.9rem" }}>
                  <input 
                    type="radio" 
                    name="move-type" 
                    checked={moveType === 'all'} 
                    onChange={() => setMoveType('all')} 
                  /> Move all colonies (Updates GPS coordinates)
                </label>
              </div>
              <div style={{ display: "flex", gap: "1rem", marginTop: "0.5rem" }}>
                <label className="tamper-toggle-label" style={{ color: "var(--color-text-main)", fontSize: "0.9rem" }}>
                  <input 
                    type="radio" 
                    name="move-type" 
                    checked={moveType === 'some'} 
                    onChange={() => setMoveType('some')} 
                  /> Move some colonies (Split group & create new Location ID)
                </label>
              </div>
            </div>

            {moveType === 'some' && (
              <div className="form-group">
                <label className="form-label" htmlFor="colony-move-count-input">Number of Colony Boxes to Move</label>
                <input 
                  id="colony-move-count-input"
                  type="number" 
                  className="form-input" 
                  min="1" 
                  max={activeApiaryForMove.hiveCount - 1} 
                  value={moveCount} 
                  onChange={(e) => setMoveCount(e.target.value)} 
                  required
                />
                <span style={{ fontSize: "0.75rem", color: "var(--color-warning-dark)" }}>
                  {activeApiaryForMove.hiveCount - moveCount} boxes will remain at {activeApiaryForMove.name}.
                </span>
              </div>
            )}

            <div className="form-group">
              <label className="form-label" htmlFor="new-gps-input">New GPS Location (latitude, longitude)</label>
              <input 
                id="new-gps-input"
                type="text" 
                className="form-input" 
                placeholder="e.g. 28.8412, 79.1123" 
                value={newGps}
                onChange={(e) => setNewGps(e.target.value)}
                required
              />
            </div>

            <div className="form-group">
              <label className="form-label" htmlFor="new-location-name-input">New Site Name (Optional)</label>
              <input 
                id="new-location-name-input"
                type="text" 
                className="form-input" 
                placeholder={moveType === 'all' ? "Update name..." : "e.g. Apiary 1 Branch South"} 
                value={newLocationName}
                onChange={(e) => setNewLocationName(e.target.value)}
              />
            </div>

            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowMoveModal(false)}>
                Cancel
              </button>
              <button className="btn btn-primary" onClick={handleExecuteMove}>
                Confirm Movement
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
