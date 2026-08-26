import React, { useState } from 'react';
import { Hexagon, ArrowRight, ShieldCheck, ClipboardCheck, Compass, Upload } from 'lucide-react';

export default function LandingPage({ setView, setActiveTraceId }) {
  const [isScanning, setIsScanning] = useState(false);

  const handleQrUpload = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Simulate scanning verification delay
    setIsScanning(true);
    setTimeout(() => {
      setIsScanning(false);
      // Automatically redirect to the public batch verification page
      setActiveTraceId('BT-LIC001-20260825-01');
      setView('consumer-trace');
    }, 1500);
  };

  return (
    <div className="app-container">
      {/* Header */}
      <header className="navbar">
        <div className="logo-container" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
          <span className="logo-icon">
            <Hexagon size={28} fill="#F5A623" color="#D97706" strokeWidth={2} />
          </span>
          <span>HoneyChain</span>
        </div>
        <nav>
          <ul className="nav-links">
            <li><a href="#about" onClick={(e) => { e.preventDefault(); alert("HoneyChain is a tamper-evident honey traceability and smart apiary management platform built for agricultural transparency."); }}>About</a></li>
            <li><a href="#how-it-works" onClick={(e) => { e.preventDefault(); document.getElementById('how-it-works-section')?.scrollIntoView({ behavior: 'smooth' }); }}>How It Works</a></li>
            <li>
              <button className="btn btn-primary" onClick={() => setView('role-selection')}>
                Get Started
              </button>
            </li>
          </ul>
        </nav>
      </header>

      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-content">
          <div className="hero-badge">
            <ShieldCheck size={16} />
            <span>Smart India Hackathon 2026 Prototype</span>
          </div>
          <h1 className="hero-title">Trace Every Drop. <br />Manage Every Hive.</h1>
          <p className="hero-subtitle">
            HoneyChain combines transparent sourcing, laboratory verification, and tamper-evident blockchain records with smart beekeeping management for an end-to-end trustworthy honey supply chain.
          </p>

          <div className="hero-actions" style={{ justifyContent: 'center', gap: '1rem', display: 'flex' }}>
            <button className="btn btn-primary" onClick={() => setView('role-selection')}>
              Get Started <ArrowRight size={18} />
            </button>
            <button className="btn btn-secondary" onClick={() => document.getElementById('how-it-works-section')?.scrollIntoView({ behavior: 'smooth' })}>
              How It Works
            </button>
          </div>

          {/* QR Image Upload Convenience Option */}
          <div style={{ marginTop: '2.5rem', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '0.75rem', padding: '1.25rem 2rem', border: '1px dashed var(--color-border)', borderRadius: 'var(--radius-lg)', maxWidth: '420px', margin: '2.5rem auto 0 auto', backgroundColor: 'rgba(255, 255, 255, 0.6)', boxShadow: 'var(--shadow-sm)' }}>
            <span style={{ fontSize: '0.9rem', color: 'var(--color-text-muted)', fontWeight: 500 }}>
              Have a product QR code image?
            </span>
            <button 
              className="btn btn-outline-green" 
              onClick={() => document.getElementById('qr-upload-input')?.click()}
              style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem', padding: '0.5rem 1rem' }}
            >
              <Upload size={15} /> Upload QR Code Label
            </button>
            <input 
              id="qr-upload-input"
              type="file" 
              accept="image/*" 
              style={{ display: 'none' }} 
              onChange={handleQrUpload} 
            />
            <p style={{ fontSize: '0.72rem', color: 'var(--color-text-light)', margin: 0 }}>
              Upload any honey jar QR label image to simulate scanning.
            </p>
          </div>
        </div>
      </section>

      {/* Scanning QR Overlay */}
      {isScanning && (
        <div className="modal-overlay">
          <div className="modal-content" style={{ maxWidth: '350px', textAlign: 'center', padding: '2.5rem' }}>
            <div className="flow-circle active" style={{ margin: '0 auto 1.5rem auto', width: '3.5rem', height: '3.5rem', animation: 'pulse 1.2s infinite' }}>
              <Upload size={24} style={{ color: 'white' }} />
            </div>
            <h3 style={{ fontSize: '1.25rem', marginBottom: '0.5rem' }}>Scanning QR Code...</h3>
            <p style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>
              Extracting batch record URL parameter and querying the blockchain integrity status...
            </p>
          </div>
        </div>
      )}

      {/* Value Cards */}
      <section className="section-container" id="about">
        <h2 className="section-title">Why HoneyChain?</h2>
        <div className="grid-3">
          <div className="value-card">
            <div className="card-icon-wrapper icon-yellow">
              <Compass size={28} />
            </div>
            <h3>Traceability</h3>
            <p>Track honey batches directly from hive inspections to the final packaging jars, maintaining a crystal clear origin trail.</p>
          </div>

          <div className="value-card">
            <div className="card-icon-wrapper icon-green">
              <ClipboardCheck size={28} />
            </div>
            <h3>Verification</h3>
            <p>Verify official apiary registrations, beekeeper licenses, and authorized laboratory purity report indicators before sale.</p>
          </div>

          <div className="value-card">
            <div className="card-icon-wrapper icon-purple">
              <ShieldCheck size={28} />
            </div>
            <h3>Smart Beekeeping</h3>
            <p>Manage multiple apiary positions, log hive box statuses, and split colony populations efficiently in a secure environment.</p>
          </div>
        </div>
      </section>

      {/* How it Works flow */}
      <section className="section-container" id="how-it-works-section" style={{ borderTop: "1px solid var(--color-border)", paddingTop: "4rem" }}>
        <div className="workflow-flow">
          <h3 className="section-title" style={{ marginBottom: "2rem" }}>How HoneyChain Works</h3>
          <div className="flow-container">
            <div className="flow-step">
              <div className="flow-circle active">1</div>
              <span>Beekeeper Registry</span>
            </div>
            <div className="flow-arrow"><ArrowRight size={20} /></div>

            <div className="flow-step">
              <div className="flow-circle active">2</div>
              <span>Harvest Registry</span>
            </div>
            <div className="flow-arrow"><ArrowRight size={20} /></div>

            <div className="flow-step">
              <div className="flow-circle active">3</div>
              <span>Lab Verification</span>
            </div>
            <div className="flow-arrow"><ArrowRight size={20} /></div>

            <div className="flow-step">
              <div className="flow-circle secondary-active">4</div>
              <span>Company Batching</span>
            </div>
            <div className="flow-arrow"><ArrowRight size={20} /></div>

            <div className="flow-step">
              <div className="flow-circle secondary-active">5</div>
              <span>Tamper Check</span>
            </div>
            <div className="flow-arrow"><ArrowRight size={20} /></div>

            <div className="flow-step">
              <div className="flow-circle active">6</div>
              <span>Consumer QR Code</span>
            </div>
          </div>
          <p style={{ marginTop: "2rem", color: "var(--color-text-muted)", fontSize: "0.9rem" }}>
            Each step links records to a blockchain ledger hash. Any alterations in the record details automatically trip a mismatch warning during consumer verification.
          </p>
        </div>
      </section>

      {/* Footer */}
      <footer style={{ backgroundColor: "#F3F4F6", padding: "2.5rem 5%", textAlign: "center", borderTop: "1px solid var(--color-border)", marginTop: "auto" }}>
        <p style={{ fontSize: "0.85rem", color: "var(--color-text-muted)" }}>
          &copy; 2026 HoneyChain platform. Prototype built for Smart India Hackathon. All identity and license databases are synthetic mock data for demonstration.
        </p>
      </footer>
    </div>
  );
}
