import React from 'react';
import { User, Building, ArrowLeft, Hexagon } from 'lucide-react';

export default function RoleSelection({ setView }) {
  return (
    <div className="auth-page">
      <div className="auth-container">
        {/* Back Button */}
        <button 
          className="btn btn-secondary" 
          onClick={() => setView('landing')} 
          style={{ marginBottom: "2rem", display: "inline-flex", alignItems: "center" }}
        >
          <ArrowLeft size={16} /> Back to Home
        </button>

        {/* Wordmark logo */}
        <div style={{ display: "flex", justifyContent: "center", alignItems: "center", gap: "0.5rem", marginBottom: "1rem" }}>
          <Hexagon size={32} fill="#F5A623" color="#D97706" strokeWidth={2} />
          <h2 style={{ fontSize: "1.5rem", fontWeight: 700 }}>HoneyChain</h2>
        </div>

        <h1 className="auth-title">How are you registering?</h1>
        <p className="auth-subtitle">Select your account type to proceed to the registration and verification portals.</p>

        <div className="role-cards-grid">
          {/* Beekeeper Card */}
          <div className="role-card" onClick={() => setView('beekeeper-verify')}>
            <div className="role-card-icon">
              <User size={32} />
            </div>
            <h3>Solo Beekeeper</h3>
            <p>Register and manage your own honey harvests, hives, apiary locations, and health observations.</p>
            <button className="btn btn-primary" style={{ width: "100%" }}>
              Select Solo Beekeeper
            </button>
          </div>

          {/* Company Card */}
          <div className="role-card" onClick={() => setView('company-verify')}>
            <div className="role-card-icon">
              <Building size={32} />
            </div>
            <h3>Company / Processor</h3>
            <p>Register as a honey processing or selling company, select source harvests, and create traceable batches.</p>
            <button className="btn btn-green" style={{ width: "100%" }}>
              Select Company / Processor
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
