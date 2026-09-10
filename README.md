# Enterprise FP&A: 3-Statement Model, Working Capital & What-If Simulations

## Executive Overview
This repository hosts the end-to-end analytical framework for an enterprise-level FP&A and Corporate Controlling system. Moving from raw relational ERP transactions (SQL General Ledger) to an executive Power BI decision dashboard, the project models company performance across operating profitability, liquidity reconciliation, and strategic risk assessment for the CFO and executive board.

---

## Technical Stack & Data Architecture
* **Database & Data Engineering:** SQL (ANSI / SQLite / PostgreSQL compatible)
  * Normalized Star Schema with transactional General Ledger (`Fact_GL`)
  * Master dimensions: `Dim_Account` (COA), `Dim_CostCenter`, `Dim_Customer`, `Dim_Vendor`, `Dim_Calendar`
  * Window Functions (`ROW_NUMBER`, `OVER PARTITION BY`) and recursive queries for running balances
  * Indexed database views for dynamic statement aggregation
* **BI Engine & Modeling:** Power BI Desktop & VertiPaq Engine
  * Pure 1:N Star Schema design with unidirectional filter flows
  * Disconnected parameter tables for real-time scenario simulation
* **Analytical Calculations:** Advanced Financial DAX
  * Multi-tier cascaded profitability logic
  * Non-standard financial matrix structuring with automated sign management
  * Dynamic Time Intelligence (YoY, YTD, MoM)

---

## Core Business Modules

### 1. Multi-Tier Income Statement (P&L)
* **Net Revenue:** Gross billed sales adjusted for contractual returns and trade discounts.
* **Contribution Margin I & II:** Direct variable costing breakdown by business line and product category.
* **EBITDA & EBIT:** Operational margin isolation by mapping fixed corporate overheads, depreciation schedules, and risk provisions.

### 2. Indirect Cash Flow & Working Capital Dynamics
* **Operating Cash Flow (OCF):** Automated bridge reconciling Net Income to operational liquidity:
  $$\text{OCF} = \text{Net Income} + \text{D&A} - \Delta\text{Accounts Receivable} - \Delta\text{Inventory} + \Delta\text{Accounts Payable}$$
* **Free Cash Flow to Firm (FCFF):** Net operational cash generation deducting CAPEX commitments.
* **Cash Conversion Cycle KPIs:** Automated computation of DSO (Days Sales Outstanding), DPO (Days Payable Outstanding), and DIO (Days Inventory Outstanding).

### 3. CFO What-If & Stress-Testing Simulator
* Dynamic interactive sliders simulating:
  * Raw material cost inflation ($\pm 10\%$)
  * Energy/utility cost fluctuations ($\pm 20\%$)
  * Demand volume contraction/expansion ($\pm 15\%$)
* Instant real-time recalculation of cash runway and operational break-even points.

---

## Repository Contents
* `/sql`: DDL schema definitions, seed transactional data (`Fact_GL`), and analytical reporting views (`vw_Financial_Statements`, `vw_WorkingCapital_Movement`).
* `/powerbi`: `.pbix` data model containing all star schema relationships, DAX measure tables, and executive dashboard layouts.
* `/docs`: Technical documentation and executive PDF summary.
* 
