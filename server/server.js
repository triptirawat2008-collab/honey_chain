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
app.get("/api/verify/ulr/:ulrNumber", async (req, res) => {
    try {
        const { ulrNumber } = req.params;

        const result = await pool.query(
            `SELECT ulr_number, lab_id, lab_name,
                    nabl_certificate_number,
                    accreditation_status,
                    state, city,
                    report_number,
                    report_date,
                    sample_id
             FROM verification.lab_report_registry
             WHERE ulr_number = $1`,
            [ulrNumber]
        );

        if (result.rows.length === 0) {
            return res.json({
                verified: false,
                message: "ULR not found"
            });
        }

        res.json({
            verified: true,
            message: "ULR verified",
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

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`HoneyChain backend running on http://localhost:${PORT}`);
});