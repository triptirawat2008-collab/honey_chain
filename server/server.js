import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import pg from "pg";

dotenv.config();

const { Pool } = pg;

const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
});

app.get("/", (req, res) => {
    res.json({
        message: "HoneyChain backend is running"
    });
});

app.get("/api/test-db", async (req, res) => {
    try {
        const result = await pool.query("SELECT NOW()");

        res.json({
            success: true,
            message: "PostgreSQL connected successfully",
            time: result.rows[0].now
        });
    } catch (error) {
        console.error("Database connection error:", error);

        res.status(500).json({
            success: false,
            message: "Database connection failed"
        });
    }
});

app.get("/api/verify/beekeeper/:beekeeperId", async (req, res) => {
    try {
        const { beekeeperId } = req.params;

        const result = await pool.query(
            `SELECT beekeeper_id, registered_name, state, status
             FROM verification.beekeeper_registry
             WHERE beekeeper_id = $1`,
            [beekeeperId]
        );

        if (result.rows.length === 0) {
            return res.json({
                verified: false,
                message: "Beekeeper ID not found"
            });
        }

        res.json({
            verified: true,
            message: "Beekeeper ID verified",
            data: result.rows[0]
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            verified: false,
            message: "Database verification failed"
        });
    }
});
app.get("/api/verify/license/:licenseNumber", async (req, res) => {
    try {
        const { licenseNumber } = req.params;

        const result = await pool.query(
            `SELECT license_number, company_name, state,
                    issue_date, expiry_date, license_status,
                    issuing_authority
             FROM verification.license_registry
             WHERE license_number = $1`,
            [licenseNumber]
        );

        if (result.rows.length === 0) {
            return res.json({
                verified: false,
                message: "License number not found"
            });
        }

        res.json({
            verified: true,
            message: "License number found",
            data: result.rows[0]
        });

    } catch (error) {
        console.error(error);

        res.status(500).json({
            verified: false,
            message: "Database verification failed"
        });
    }
});

app.post("/api/verify-ulr", async (req, res) => {
    const { ulrNumber } = req.body;

    if (!ulrNumber) {
        return res.status(400).json({
            verified: false,
            message: "ULR ID is required"
        });
    }

    try {
        const result = await pool.query(
            `SELECT *
FROM verification.lab_report_registry          
   WHERE ulr_number = $1`,
            [ulrNumber]
        );

        if (result.rows.length > 0) {
            return res.json({
                verified: true,
                lab: result.rows[0]
            });
        }

        return res.json({
            verified: false,
            message: "ULR ID not found"
        });

    } catch (error) {
        console.error(error);

        return res.status(500).json({
            verified: false,
            message: "Database verification failed"
        });
    }
});
// ==========================================
// 1. SMART BEEKEEPING ROUTES
// ==========================================

// Create a new Apiary Location
app.post('/api/locations', async (req, res) => {
  try {
    const { location_id, beekeeper_id, name, gps_coordinates, hive_count } = req.body;

    const query = `
      INSERT INTO apiary_locations (location_id, beekeeper_id, name, gps_coordinates, hive_count)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;
    const values = [location_id, beekeeper_id, name || 'Apiary Site', gps_coordinates, hive_count];
    const result = await pool.query(query, values);

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (err) {
    console.error('APIARY CREATION ERROR:', err.message);
    res.status(500).json({ success: false, error: err.message });
  }
});
app.get('/api/locations/:beekeeper_id', async (req, res) => {
    try {
        const { beekeeper_id } = req.params;

        const result = await pool.query(
            `SELECT *
             FROM apiary_locations
             WHERE beekeeper_id = $1
             ORDER BY created_at ASC`,
            [beekeeper_id]
        );

        res.json({
            success: true,
            data: result.rows
        });

    } catch (err) {
        console.error("Error fetching locations:", err.message);

        res.status(500).json({
            success: false,
            error: "Failed to fetch apiaries"
        });
    }
});

// Add a Health Log for an Apiary
app.post('/api/health-logs', async (req, res) => {
  try {
    const { location_id, status, notes, inspection_date } = req.body;

    const query = `
      INSERT INTO health_logs (location_id, status, notes, inspection_date)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    const values = [location_id, status, notes, inspection_date];
    const result = await pool.query(query, values);

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ success: false, error: 'Failed to save health log' });
  }
});

app.get('/api/health-logs/:beekeeper_id', async (req, res) => {
  try {
    const { beekeeper_id } = req.params;

    const result = await pool.query(
      `SELECT hl.*, al.beekeeper_id, al.name AS location_name
       FROM health_logs hl
       JOIN apiary_locations al ON hl.location_id = al.location_id
       WHERE al.beekeeper_id = $1
       ORDER BY hl.inspection_date DESC, hl.created_at DESC`,
      [beekeeper_id]
    );

    res.json({
      success: true,
      data: result.rows
    });
  } catch (err) {
    console.error('Error fetching health logs:', err.message);

    res.status(500).json({
      success: false,
      error: 'Failed to fetch health logs'
    });
  }
});

// ==========================================
// 2. TRACEABILITY ROUTES (Solo Beekeeper)
// ==========================================

// Create a Harvest
// POST route to create a new harvest record
// POST route to create a new harvest record
// POST route to create a new harvest record
// POST route to create a new harvest record
app.post('/api/harvests', async (req, res) => {
  try {
    const {
      harvest_id,
      beekeeper_id,
      harvest_date,
      flower_sources,
      location_id,
      gps_coordinates,
      lab_ulr,
      ulr_status,
      block_hash,
      tx_ref,
      quantity_kg
    } = req.body;

    const query = `
      INSERT INTO harvests (
        harvest_id, beekeeper_id, harvest_date, flower_sources, location_id,
        lab_ulr, ulr_status, block_hash, tx_ref, quantity_kg   -- Changed inside the SQL string here!
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *;
    `;

    const values = [
      harvest_id,
      beekeeper_id,
      harvest_date,
      JSON.stringify(flower_sources), // Safely converts the array for SQL
      location_id,
      lab_ulr || null,
      ulr_status || 'Verified',
      block_hash,
      tx_ref,
      quantity_kg || 160
    ];

    if (gps_coordinates) {
      console.log('Harvest GPS payload received:', gps_coordinates);
    }

    const result = await pool.query(query, values);
    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (err) {
    console.error('Database Error saving harvest:', err.message);
    res.status(500).json({ success: false, error: err.message });
  }
});
// Get all harvests for a beekeeper
app.get('/api/harvests/:beekeeper_id', async (req, res) => {
  try {
    const { beekeeper_id } = req.params;

    const result = await pool.query(
      `SELECT * 
       FROM harvests
       WHERE beekeeper_id = $1
       ORDER BY harvest_date DESC`,
      [beekeeper_id]
    );

    res.json({
      success: true,
      data: result.rows
    });

  } catch (err) {
    console.error('Database Error fetching harvests:', err.message);

    res.status(500).json({
      success: false,
      error: 'Failed to fetch harvests'
    });
  }
});
// Verify a Harvest ID before adding it to a company batch
app.get('/api/harvests/verify/:harvest_id', async (req, res) => {
  try {
    const { harvest_id } = req.params;

    const result = await pool.query(
      `
      SELECT
        harvest_id,
        beekeeper_id,
        harvest_date,
        flower_sources,
        location_id,
        quantity_kg,
        lab_ulr,
        ulr_status
      FROM harvests
      WHERE harvest_id = $1
      `,
      [harvest_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        verified: false,
        message: 'Harvest ID not found'
      });
    }

    res.json({
      verified: true,
      message: 'Harvest ID verified',
      data: result.rows[0]
    });

  } catch (err) {
    console.error('Harvest verification error:', err.message);

    res.status(500).json({
      verified: false,
      message: 'Database verification failed',
      error: err.message
    });
  }
});

// ==========================================
// 3. TRACEABILITY ROUTES (Company Batching)
// ==========================================

// Create a Batch and Link Multiple Harvests
app.post('/api/batches', async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      batch_id,
      company_license,
      product_name,
      quantity_kg,
      final_lab_ulr,
      ulr_status,
      manual_report_certified,
      is_lab_certified,
      harvest_ids
    } = req.body;

    await client.query('BEGIN');

    // Save batch
    await client.query(
      `INSERT INTO batches (
        batch_id,
        company_license,
        product_name,
        quantity_kg,
        final_lab_ulr,
        ulr_status,
        manual_report_certified,
        is_lab_certified
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)`,
      [
        batch_id,
        company_license,
        product_name,
        quantity_kg,
        final_lab_ulr || null,
        ulr_status || 'Verified',
        manual_report_certified || false,
        is_lab_certified || false
      ]
    );

    // Save source harvest relationships
    if (Array.isArray(harvest_ids)) {
      for (const harvest_id of harvest_ids) {
        await client.query(
          `INSERT INTO batch_harvest_mapping (batch_id, harvest_id)
           VALUES ($1, $2)`,
          [batch_id, harvest_id]
        );
      }
    }

    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'Batch created successfully',
      batch_id
    });

} catch (err) {
  await client.query('ROLLBACK');

  console.error('BATCH DATABASE ERROR:', err);

  res.status(500).json({
    success: false,
    error: err.message,
    detail: err.detail || null,
    code: err.code || null
  });
}finally {
    client.release();
  }
});
// ==========================================
// GET ALL BATCHES FOR A COMPANY
// ==========================================
app.get('/api/batches/:company_license', async (req, res) => {
  try {
    const { company_license } = req.params;

    const result = await pool.query(
      `
      SELECT
        b.*,
        COALESCE(
          ARRAY_AGG(bhm.harvest_id)
          FILTER (WHERE bhm.harvest_id IS NOT NULL),
          '{}'
        ) AS harvest_ids
      FROM batches b
      LEFT JOIN batch_harvest_mapping bhm
        ON b.batch_id = bhm.batch_id
      WHERE b.company_license = $1
      GROUP BY b.batch_id
      ORDER BY b.created_at DESC;
      `,
      [company_license]
    );

    res.json({
      success: true,
      data: result.rows
    });

  } catch (err) {
    console.error('Database Error fetching company batches:', err.message);

    res.status(500).json({
      success: false,
      error: 'Failed to fetch company batches'
    });
  }
});

// ==========================================
// 4. PUBLIC CONSUMER QR TRACEABILITY ROUTE
// ==========================================

app.get('/api/batches/verify/:batchId', async (req, res) => {
  try {
    const { batchId } = req.params;

    const query = `
      SELECT
        b.batch_id,
        b.company_license,
        lr.company_name,
        b.product_name,
        b.quantity_kg,
        b.created_at,
        b.final_lab_ulr,
        b.ulr_status,
        b.is_lab_certified,
        b.manual_report_certified
      FROM batches b
      LEFT JOIN verification.license_registry lr
        ON lr.license_number = b.company_license
      WHERE b.batch_id = $1
    `;

    const result = await pool.query(query, [batchId]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        verified: false,
        message: 'Batch ID not found'
      });
    }

    return res.json({
      verified: true,
      batch: result.rows[0]
    });
  } catch (error) {
    console.error('Batch verification error:', error);
    return res.status(500).json({
      verified: false,
      message: 'Could not connect to the verification service.'
    });
  }
});


app.get('/api/trace/:traceId', async (req, res) => {
  try {
    const { traceId } = req.params;

    // ==========================================
    // 1. CHECK IF TRACE ID IS A BATCH
    // ==========================================

    const batchQuery = `
      SELECT
        b.batch_id,
        b.company_license,
        lr.company_name,
        b.product_name,
        b.quantity_kg,
        b.created_at,
        b.final_lab_ulr,
        b.ulr_status,
        b.is_lab_certified,
        b.manual_report_certified
      FROM batches b
      LEFT JOIN verification.license_registry lr
        ON lr.license_number = b.company_license
      WHERE b.batch_id = $1
    `;

    const batchRes = await pool.query(batchQuery, [traceId]);

    if (batchRes.rows.length > 0) {

      const batch = batchRes.rows[0];

      // ==========================================
      // 2. GET ALL HARVESTS LINKED TO THIS BATCH
      // ==========================================

      const harvestQuery = `
        SELECT
          h.harvest_id,
          h.beekeeper_id,
          br.registered_name AS beekeeper_name,
          br.state,
          al.name AS location_name,
          h.harvest_date,
          h.flower_sources,
          h.quantity_kg AS harvest_quantity_kg,
          h.lab_ulr,
          h.ulr_status AS harvest_ulr_status,
          COALESCE(h.ulr_status, 'Unverified') AS verification_status,
          h.block_hash,
          h.tx_ref
        FROM batch_harvest_mapping bhm
        JOIN harvests h
          ON h.harvest_id = bhm.harvest_id
        LEFT JOIN verification.beekeeper_registry br
          ON br.beekeeper_id = h.beekeeper_id
        LEFT JOIN apiary_locations al
          ON al.location_id = h.location_id
        WHERE bhm.batch_id = $1
        ORDER BY h.harvest_date DESC, h.harvest_id ASC
      `;

      const harvestRes = await pool.query(
        harvestQuery,
        [traceId]
      );

      const harvests = harvestRes.rows;

      // ==========================================
      // 3. GET LAB REPORT FOR EACH HARVEST
      // ==========================================

      const harvestLabReports = [];

      for (const harvest of harvests) {

        if (!harvest.lab_ulr) {
          harvestLabReports.push({
            harvest_id: harvest.harvest_id,
            lab: null
          });

          continue;
        }

        const labResult = await pool.query(
          `
          SELECT
            ulr_number,
            lab_id,
            lab_name,
            nabl_certificate_number,
            accreditation_status,
            state,
            city,
            report_number,
            report_date,
            sample_id
          FROM verification.lab_report_registry
          WHERE ulr_number = $1
          LIMIT 1
          `,
          [harvest.lab_ulr]
        );

        harvestLabReports.push({
          harvest_id: harvest.harvest_id,
          lab: labResult.rows[0] || null
        });
      }

      // ==========================================
      // 4. GET FINAL COMPANY LAB REPORT
      // ==========================================

      let companyLab = null;

      if (batch.final_lab_ulr) {

        const companyLabResult = await pool.query(
          `
          SELECT
            ulr_number,
            lab_id,
            lab_name,
            nabl_certificate_number,
            accreditation_status,
            state,
            city,
            report_number,
            report_date,
            sample_id
          FROM verification.lab_report_registry
          WHERE ulr_number = $1
          LIMIT 1
          `,
          [batch.final_lab_ulr]
        );

        if (companyLabResult.rows.length > 0) {
          companyLab = companyLabResult.rows[0];
        }
      }

      // ==========================================
      // 5. RETURN COMPLETE BATCH TRACEABILITY
      // ==========================================

      return res.json({
        verified: true,
        recordType: 'batch',

        batch: batch,

        company: {
          company_name: batch.company_name || null,
          company_license: batch.company_license || null
        },

        lab: companyLab,

        harvests: harvests,

        harvestLabReports: harvestLabReports
      });
    }

    // ==========================================
    // 6. IF NOT A BATCH, CHECK IF IT IS A HARVEST
    // ==========================================

    const harvestQuery = `
      SELECT
        h.harvest_id,
        h.beekeeper_id,
        br.registered_name AS beekeeper_name,
        br.state,
        al.name AS location_name,
        h.harvest_date,
        h.flower_sources,
        h.quantity_kg,
        h.lab_ulr,
        h.ulr_status,
        h.block_hash,
        h.tx_ref,
        COALESCE(
          h.ulr_status,
          'Unverified'
        ) AS verification_status,
        al.location_id,
        al.gps_coordinates
      FROM harvests h
      LEFT JOIN verification.beekeeper_registry br
        ON br.beekeeper_id = h.beekeeper_id
      LEFT JOIN apiary_locations al
        ON al.location_id = h.location_id
      WHERE h.harvest_id = $1
    `;

    const harvestRes = await pool.query(
      harvestQuery,
      [traceId]
    );

    if (harvestRes.rows.length === 0) {
      return res.status(404).json({
        verified: false,
        message: 'Trace ID not found in either batch or harvest records'
      });
    }

    const harvest = harvestRes.rows[0];

    // ==========================================
    // 7. GET HARVEST LAB REPORT
    // ==========================================

    let harvestLab = null;

    if (harvest.lab_ulr) {

      const labResult = await pool.query(
        `
        SELECT
          ulr_number,
          lab_id,
          lab_name,
          nabl_certificate_number,
          accreditation_status,
          state,
          city,
          report_number,
          report_date,
          sample_id
        FROM verification.lab_report_registry
        WHERE ulr_number = $1
        LIMIT 1
        `,
        [harvest.lab_ulr]
      );

      if (labResult.rows.length > 0) {
        harvestLab = labResult.rows[0];
      }
    }

    // ==========================================
    // 8. RETURN HARVEST TRACEABILITY
    // ==========================================

    return res.json({
      verified: true,
      recordType: 'harvest',

      harvest: harvest,

      company: {
        company_name: null,
        company_license: null
      },

      harvests: [harvest],

      lab: harvestLab,

      harvestLabReports: [
        {
          harvest_id: harvest.harvest_id,
          lab: harvestLab
        }
      ]
    });

  } catch (error) {

    console.error('Traceability fetch error:', error);

    return res.status(500).json({
      verified: false,
      message: 'Failed to fetch traceability data',
      error: error.message
    });
  }
});

app.get('/api/traceability/:batch_id', async (req, res) => {
  const { batch_id } = req.params;
  const traceRes = await fetch(`http://localhost:${process.env.PORT || 5000}/api/trace/${encodeURIComponent(batch_id)}`);
  const traceData = await traceRes.json();

  if (!traceRes.ok || !traceData.verified) {
    return res.status(404).json({
      success: false,
      verified: false,
      message: 'Batch ID not found'
    });
  }

  return res.json({
    success: true,
    verified: true,
    ...traceData
  });
});
// Fetch all apiary locations for a specific beekeeper


// Fetch all harvest records for a specific beekeeper


const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`HoneyChain backend running on http://localhost:${PORT}`);
});