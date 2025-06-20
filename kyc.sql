USE [kyc]
GO
/****** Object:  User [dev_casemgmt]    Script Date: 20-Jun-25 1:12:30 AM ******/
CREATE USER [dev_casemgmt] FOR LOGIN [dev_casemgmt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dev_casemgmt_icon]    Script Date: 20-Jun-25 1:12:30 AM ******/
CREATE USER [dev_casemgmt_icon] FOR LOGIN [dev_casemgmt_icon] WITH DEFAULT_SCHEMA=[kyc]
GO
/****** Object:  User [dev_cmsvi_user]    Script Date: 20-Jun-25 1:12:30 AM ******/
CREATE USER [dev_cmsvi_user] FOR LOGIN [dev_cmsvi_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [kyc_user]    Script Date: 20-Jun-25 1:12:30 AM ******/
CREATE USER [kyc_user] FOR LOGIN [kyc_user] WITH DEFAULT_SCHEMA=[kyc]
GO
/****** Object:  User [uat_casemgmt]    Script Date: 20-Jun-25 1:12:30 AM ******/
CREATE USER [uat_casemgmt] FOR LOGIN [uat_casemgmt] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [dev_casemgmt]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dev_casemgmt]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dev_casemgmt]
GO
ALTER ROLE [db_owner] ADD MEMBER [dev_casemgmt_icon]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [dev_casemgmt_icon]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dev_casemgmt_icon]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dev_cmsvi_user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dev_cmsvi_user]
GO
ALTER ROLE [db_owner] ADD MEMBER [uat_casemgmt]
GO
/****** Object:  Schema [kyc]    Script Date: 20-Jun-25 1:12:31 AM ******/
CREATE SCHEMA [kyc]
GO
/****** Object:  Table [dbo].[KYC_STAKEHOLER_REQUEST_ALAMAL]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KYC_STAKEHOLER_REQUEST_ALAMAL](
	[KYC_STAKEHOLER_ID] [int] NOT NULL,
	[FULL_NAME] [varchar](255) NULL,
	[NATIONALITY] [varchar](100) NULL,
	[ROLE] [varchar](100) NULL,
	[DOB] [varchar](100) NULL,
	[KYC_REQUEST_ID] [varchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[customer_master_staging]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[customer_master_staging](
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[address3] [varchar](255) NULL,
	[age] [varchar](255) NULL,
	[annual_income] [int] NULL,
	[area_code] [varchar](255) NULL,
	[block_unblock_date] [varchar](255) NULL,
	[block_unblock_reason] [varchar](255) NULL,
	[block_unblock_user] [varchar](255) NULL,
	[branch] [varchar](255) NULL,
	[business_name] [varchar](255) NULL,
	[complex_org_structure_flag] [varchar](255) NULL,
	[corporate_dealing_with] [varchar](255) NULL,
	[corporate_nature] [varchar](255) NULL,
	[corporate_other_info] [varchar](255) NULL,
	[corporate_type] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[country_of_incorporation] [varchar](255) NULL,
	[customer_code] [varchar](255) NOT NULL,
	[customer_type] [varchar](255) NULL,
	[date_of_incorporation] [varchar](255) NULL,
	[delivery_channel] [varchar](255) NULL,
	[dnfbp_dpms_flag] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[email_id] [varchar](255) NULL,
	[employee_flag] [varchar](255) NULL,
	[employer_name] [varchar](255) NULL,
	[employment_type] [varchar](255) NULL,
	[expected_annual_txn_cnt] [varchar](255) NULL,
	[expected_annual_txn_val] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fla_user_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[gender] [varchar](255) NULL,
	[id_expiry_date] [varchar](255) NULL,
	[id_issue_date] [varchar](255) NULL,
	[id_issuing_country] [varchar](255) NULL,
	[id_issuing_state] [varchar](255) NULL,
	[id_number] [varchar](255) NULL,
	[id_reverse_number] [varchar](255) NULL,
	[id_scan_type] [varchar](255) NULL,
	[id_type] [varchar](255) NULL,
	[is_web_remit_user] [varchar](255) NULL,
	[judicial_sector] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[legal_status] [varchar](255) NULL,
	[middle_name] [varchar](255) NULL,
	[mobile_number] [varchar](255) NULL,
	[mobile_number2] [varchar](255) NULL,
	[mode_of_cus_reg] [varchar](255) NULL,
	[nationality] [varchar](255) NULL,
	[nature_of_business] [varchar](255) NULL,
	[pep] [varchar](255) NULL,
	[phone1] [varchar](255) NULL,
	[place_of_birth] [varchar](255) NULL,
	[products_services] [varchar](500) NULL,
	[prof_level] [varchar](255) NULL,
	[profession] [varchar](255) NULL,
	[profile_created_date] [varchar](255) NULL,
	[profile_last_modified_date] [varchar](255) NULL,
	[residency_type] [varchar](255) NULL,
	[restrict_applied_by] [varchar](255) NULL,
	[restrict_created_dt] [varchar](255) NULL,
	[restrict_updated_by] [varchar](255) NULL,
	[restrict_updated_dt] [varchar](255) NULL,
	[source_of_income] [varchar](255) NULL,
	[state] [varchar](255) NULL,
	[trade_license_number] [varchar](255) NULL,
	[transaction_type] [varchar](max) NULL,
	[user_updated_id] [varchar](255) NULL,
	[visa_type] [varchar](255) NULL,
	[risk_band] [varchar](255) NULL,
	[risk_score] [varchar](255) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trxn_type] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [kyc].[customer_scoring_details]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[customer_scoring_details](
	[customer_code] [varchar](255) NULL,
	[customer_name] [varchar](255) NULL,
	[risk_band] [varchar](255) NULL,
	[risk_score] [float] NULL,
	[variable_name] [varchar](255) NULL,
	[variable_score] [int] NULL,
	[weight_in_percent] [float] NULL,
	[weight_score] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[customer_scoring_details_final]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[customer_scoring_details_final](
	[customer_code] [varchar](255) NULL,
	[customer_name] [varchar](255) NULL,
	[risk_band] [varchar](255) NULL,
	[risk_score] [float] NULL,
	[variable_name] [varchar](255) NULL,
	[variable_value] [varchar](255) NULL,
	[variable_score] [int] NULL,
	[weight_in_percent] [float] NULL,
	[weight_score] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_request]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_request](
	[kyc_request_id] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[account_nature] [varchar](255) NULL,
	[cust_address] [varchar](255) NULL,
	[customer_name] [varchar](255) NULL,
	[dob] [date] NULL,
	[email_id] [varchar](255) NULL,
	[employer_name] [varchar](255) NULL,
	[employment_status] [varchar](255) NULL,
	[identity_proof] [varchar](255) NULL,
	[income] [float] NULL,
	[marital_status] [varchar](255) NULL,
	[nationality] [varchar](255) NULL,
	[passport_number] [varchar](255) NULL,
	[politically_exposed_person] [varchar](255) NULL,
	[politically_exposed_person_past] [varchar](255) NULL,
	[primary_contact_number] [varchar](255) NULL,
	[profession] [varchar](255) NULL,
	[residency] [varchar](255) NULL,
	[secondary_contact_number] [varchar](255) NULL,
	[segment] [varchar](255) NULL,
	[spouse_name] [varchar](255) NULL,
	[tax_id] [varchar](255) NULL,
	[REVIEW_TYPE] [varchar](250) NULL,
	[customer_since_date] [int] NULL,
	[name_match] [varchar](255) NULL,
	[unique_number] [varchar](255) NULL,
	[age] [varchar](255) NULL,
	[emp_flag] [varchar](255) NULL,
	[id_expiry_date] [date] NULL,
	[mobile_num] [varchar](255) NULL,
	[org_email_id] [varchar](255) NULL,
	[registered_flag] [varchar](255) NULL,
	[stakeholders_name] [varchar](max) NULL,
	[unique_number_2] [varchar](255) NULL,
	[LEGAL_STATUS] [varchar](250) NULL,
	[branch_code] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_request_alamal]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_request_alamal](
	[kyc_request_id] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[al_amal_emp_flag] [varchar](255) NULL,
	[branch] [varchar](255) NULL,
	[business_name] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[country_of_incorporation] [varchar](255) NULL,
	[customer_code] [varchar](255) NULL,
	[customer_name] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[date_of_incorporation] [varchar](255) NULL,
	[dnfbp_dpms] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[email_id] [varchar](255) NULL,
	[expected_annual_txn_cnt] [int] NULL,
	[expected_annual_txn_val] [float] NULL,
	[first_name] [varchar](255) NULL,
	[fla_user_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[gender] [varchar](255) NULL,
	[id_expiry_date] [varchar](255) NULL,
	[id_issue_date] [varchar](255) NULL,
	[id_issuing_country] [varchar](255) NULL,
	[id_number] [varchar](255) NULL,
	[id_type] [varchar](255) NULL,
	[judicial_sector] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[legal_status] [varchar](255) NULL,
	[middle_name] [varchar](255) NULL,
	[mobile_number] [varchar](255) NULL,
	[name_match] [varchar](255) NULL,
	[name_of_stakeholders] [varchar](max) NULL,
	[nationality] [varchar](255) NULL,
	[nature_of_business] [varchar](255) NULL,
	[organization_structure_flag] [varchar](255) NULL,
	[pep] [varchar](255) NULL,
	[products_services] [varchar](255) NULL,
	[profession] [varchar](255) NULL,
	[residency_type] [varchar](255) NULL,
	[shareholder_nationality] [varchar](255) NULL,
	[shareholder_pep] [varchar](255) NULL,
	[state] [varchar](255) NULL,
	[trade_license_number] [varchar](255) NULL,
	[unique_number] [varchar](255) NULL,
	[unique_number_2] [varchar](100) NULL,
	[request_type] [varchar](100) NULL,
	[request_id] [varchar](255) NULL,
	[risk_score] [varchar](10) NULL,
	[risk_band] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_request_jkuae]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_request_jkuae](
	[kyc_request_id] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[address3] [varchar](255) NULL,
	[age] [varchar](255) NULL,
	[annual_income] [numeric](10, 0) NULL,
	[area_code] [varchar](255) NULL,
	[block_unblock_date] [varchar](255) NULL,
	[block_unblock_reason] [varchar](255) NULL,
	[block_unblock_user] [varchar](255) NULL,
	[branch] [varchar](255) NULL,
	[business_name] [varchar](255) NULL,
	[complex_org_structure_flag] [varchar](255) NULL,
	[corporate_dealing_with] [varchar](255) NULL,
	[corporate_nature] [varchar](255) NULL,
	[corporate_other_info] [varchar](255) NULL,
	[corporate_type] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[country_of_incorporation] [varchar](255) NULL,
	[customer_code] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[date_of_incorporation] [varchar](255) NULL,
	[delivery_channel] [varchar](255) NULL,
	[dnfbp_dpms_flag] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[email_id] [varchar](255) NULL,
	[employee_flag] [varchar](255) NULL,
	[employer_name] [varchar](255) NULL,
	[employment_type] [varchar](255) NULL,
	[expected_annual_txn_cnt] [varchar](255) NULL,
	[expected_annual_txn_val] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fla_user_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[gender] [varchar](255) NULL,
	[id_expiry_date] [varchar](255) NULL,
	[id_issue_date] [varchar](255) NULL,
	[id_issuing_country] [varchar](255) NULL,
	[id_issuing_state] [varchar](255) NULL,
	[id_number] [varchar](255) NULL,
	[id_reverse_number] [varchar](255) NULL,
	[id_scan_type] [varchar](255) NULL,
	[id_type] [varchar](255) NULL,
	[is_web_remit_user] [varchar](255) NULL,
	[judicial_sector] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[legal_status] [varchar](255) NULL,
	[middle_name] [varchar](255) NULL,
	[mobile_number] [varchar](255) NULL,
	[mobile_number2] [varchar](255) NULL,
	[mode_of_cus_reg] [varchar](255) NULL,
	[name_match] [varchar](255) NULL,
	[name_of_auth_person] [varchar](max) NULL,
	[name_of_stakeholders] [varchar](max) NULL,
	[nationality] [varchar](255) NULL,
	[nature_of_business] [varchar](255) NULL,
	[pep] [varchar](255) NULL,
	[phone1] [varchar](255) NULL,
	[place_of_birth] [varchar](255) NULL,
	[products_services] [varchar](500) NULL,
	[prof_level] [varchar](255) NULL,
	[profession] [varchar](255) NULL,
	[profile_created_date] [varchar](255) NULL,
	[profile_last_modified_date] [varchar](255) NULL,
	[residency_type] [varchar](255) NULL,
	[restrict_applied_by] [varchar](255) NULL,
	[restrict_created_dt] [varchar](255) NULL,
	[restrict_updated_by] [varchar](255) NULL,
	[restrict_updated_dt] [varchar](255) NULL,
	[source_of_income] [varchar](255) NULL,
	[state] [varchar](255) NULL,
	[trade_license_number] [varchar](255) NULL,
	[transaction_type] [varchar](max) NULL,
	[unique_number] [varchar](255) NULL,
	[unique_number_2] [varchar](255) NULL,
	[user_updated_id] [varchar](255) NULL,
	[visa_type] [varchar](255) NULL,
	[risk_band] [varchar](255) NULL,
	[risk_score] [varchar](255) NULL,
	[products_services_final] [varchar](100) NULL,
	[shareholder_nationality] [varchar](500) NULL,
	[shareholder_residency_status] [varchar](20) NULL,
	[shareholder_pep_status] [varchar](10) NULL,
	[override_cus_flag] [varchar](255) NULL,
	[risk_scoring_flag] [varchar](100) NULL,
	[screening_flag] [varchar](100) NULL,
	[REVIEW_TYPE] [varchar](100) NULL,
	[MATCH_TYPE] [varchar](20) NULL,
	[NATIONALITY_COUNTRY_NAME] [varchar](100) NULL,
	[INCORPORATION_COUNTRY_NAME] [varchar](100) NULL,
	[RISK_CATEGORY] [varchar](100) NULL,
	[SENSITIVITY] [varchar](10) NULL,
	[TYPE_DESC] [varchar](200) NULL,
	[LIST_SOURCE] [varchar](1000) NULL,
	[LIST_SUB_CAT] [varchar](1000) NULL,
	[YEARS_OF_INCORPORATION] [varchar](100) NULL,
	[NATIONALITY_COUNTRY_NAME_SCREENING] [varchar](255) NULL,
	[rule_name] [varchar](255) NULL,
	[birth_country_cdd] [varchar](10) NULL,
	[unique_number_3] [varchar](255) NULL,
	[dowjones_category] [varchar](1000) NULL,
	[request_id] [varchar](100) NULL,
	[trxn_type] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_request_savington]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_request_savington](
	[kyc_request_id] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[dob] [varchar](255) NULL,
	[address] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[customer_group] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[designation] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[emirates_id] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[gender] [varchar](255) NULL,
	[id_expiry_date] [varchar](255) NULL,
	[id_number] [varchar](255) NULL,
	[industry_segment] [varchar](255) NULL,
	[is_confidential] [varchar](255) NULL,
	[job_description] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[marriage_date] [varchar](255) NULL,
	[middle_name] [varchar](255) NULL,
	[mobile] [varchar](255) NULL,
	[name_match] [varchar](255) NULL,
	[nationality] [varchar](255) NULL,
	[organisation_type] [varchar](255) NULL,
	[parent_code] [varchar](255) NULL,
	[po_box] [varchar](255) NULL,
	[request_id] [varchar](255) NULL,
	[trade_license] [varchar](255) NULL,
	[unique_number] [varchar](255) NULL,
	[unique_number_2] [varchar](255) NULL,
	[verticle] [varchar](255) NULL,
	[customer_category] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_request_stakeholder_jkuae]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_request_stakeholder_jkuae](
	[STAKEHOLDER_ID] [int] NOT NULL,
	[kyc_request_id] [varchar](50) NULL,
	[NAME] [varchar](500) NULL,
	[TYPE] [varchar](50) NULL,
	[NATIONALITY] [varchar](50) NULL,
	[DOB] [date] NULL,
	[RESIDENCY] [varchar](50) NULL,
	[SHARE_PERCENT] [float] NULL,
	[ID_NUMBER] [varchar](50) NULL,
	[ID_EXPIRY_DATE] [date] NULL,
	[UB_FLAG] [varchar](5) NULL,
	[IS_PEP] [varchar](5) NULL,
	[IS_AUTH_SIGNATORY] [varchar](5) NULL,
	[IS_PRIMARY] [varchar](5) NULL,
	[TYPE_OF_ENTRY] [varchar](50) NULL,
	[NATIONALITY_COUNTRY_NAME] [varchar](255) NULL,
	[dowjones_category] [varchar](1000) NULL,
	[list_source] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_request_vooo]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_request_vooo](
	[kyc_request_id] [int] IDENTITY(1,1) NOT NULL,
	[request_id] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[nationality_country_name] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[gender] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[sensitivity] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[unique_number] [varchar](255) NULL,
	[name_match] [varchar](255) NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
 CONSTRAINT [kyc_request_vooo_pkey] PRIMARY KEY CLUSTERED 
(
	[kyc_request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_risk_analysis_response]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_risk_analysis_response](
	[kyc_risk_analysis_response_id] [int] NOT NULL,
	[variable_name] [varchar](255) NULL,
	[variable_score] [int] NULL,
	[weight] [float] NULL,
	[weight_score] [float] NULL,
	[kyc_risk_score_response_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_risk_analysis_response_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_risk_analysis_response_test]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_risk_analysis_response_test](
	[kyc_risk_analysis_response_id] [int] NOT NULL,
	[variable_name] [varchar](255) NULL,
	[variable_score] [int] NULL,
	[weight] [float] NULL,
	[weight_score] [float] NULL,
	[kyc_risk_score_response_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_risk_analysis_response_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_risk_score_response]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_risk_score_response](
	[kyc_risk_score_response_id] [int] NOT NULL,
	[customer_name] [varchar](255) NULL,
	[kyc_request_id] [int] NULL,
	[risk_band] [varchar](255) NULL,
	[risk_score] [float] NULL,
	[rule_id] [int] NULL,
	[scorecard_id] [int] NULL,
	[scorecard_name] [varchar](255) NULL,
	[overridden_risk_band] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_risk_score_response_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[kyc_risk_score_response_test]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[kyc_risk_score_response_test](
	[kyc_risk_score_response_id] [int] NOT NULL,
	[customer_name] [varchar](255) NULL,
	[kyc_request_id] [int] NULL,
	[overridden_risk_band] [varchar](255) NULL,
	[risk_band] [varchar](255) NULL,
	[risk_score] [float] NULL,
	[rule_id] [int] NULL,
	[scorecard_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[kyc_risk_score_response_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[KYC_STAKEHOLER_REQUEST_ALAMAL]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[KYC_STAKEHOLER_REQUEST_ALAMAL](
	[KYC_STAKEHOLER_ID] [int] NOT NULL,
	[FULL_NAME] [varchar](255) NULL,
	[NATIONALITY] [varchar](100) NULL,
	[ROLE] [varchar](100) NULL,
	[DOB] [varchar](100) NULL,
	[KYC_REQUEST_ID] [varchar](30) NULL,
	[created_by] [varchar](200) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](200) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[oauth_client_details]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[oauth_client_details](
	[client_id] [varchar](50) NOT NULL,
	[client_secret] [varchar](100) NULL,
	[scope] [varchar](200) NULL,
	[authorized_grant_types] [varchar](200) NULL,
	[access_token_validity] [int] NULL,
	[refresh_token_validity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[client_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[stakeholder_master_staging]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[stakeholder_master_staging](
	[Id] [int] NOT NULL,
	[CUSTOMER_CODE] [varchar](50) NULL,
	[NAME] [varchar](500) NULL,
	[TYPE] [varchar](50) NULL,
	[NATIONALITY] [varchar](50) NULL,
	[DOB] [varchar](50) NULL,
	[RESIDENCY] [varchar](50) NULL,
	[SHARE_PERCENT] [varchar](50) NULL,
	[ID_NUMBER] [varchar](50) NULL,
	[ID_EXPIRY_DATE] [varchar](50) NULL,
	[UB_FLAG] [varchar](50) NULL,
	[IS_PEP] [varchar](50) NULL,
	[IS_AUTH_SIGNATORY] [varchar](50) NULL,
	[IS_PRIMARY] [varchar](50) NULL,
	[TYPE_OF_ENTRY] [varchar](50) NULL,
 CONSTRAINT [PK__stakehol__3214EC075EFB302A] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[temp_customer_codes]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[temp_customer_codes](
	[customer_code] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[transaction_table]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[transaction_table](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[trans_ref_no] [varchar](255) NULL,
	[customer_code] [varchar](255) NULL,
	[beneficiary_code] [varchar](255) NULL,
	[beneficiary_name] [varchar](255) NULL,
	[beneficiary_nationality_code] [varchar](255) NULL,
	[beneficiary_dob] [varchar](255) NULL,
	[beneficiary_gender] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[sensitivity] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[unique_number] [varchar](255) NULL,
	[name_match] [varchar](255) NULL,
	[updated_dttm] [datetime2](7) NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[customer_name] [varchar](255) NULL,
	[request_source] [varchar](255) NULL,
 CONSTRAINT [transaction_table_pkey] PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [kyc].[users]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [kyc].[users](
	[username] [varchar](255) NOT NULL,
	[password] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [kyc].[kyc_risk_analysis_response]  WITH CHECK ADD  CONSTRAINT [FK4a31pxitk54235j0d1simrw0v] FOREIGN KEY([kyc_risk_score_response_id])
REFERENCES [kyc].[kyc_risk_score_response] ([kyc_risk_score_response_id])
GO
ALTER TABLE [kyc].[kyc_risk_analysis_response] CHECK CONSTRAINT [FK4a31pxitk54235j0d1simrw0v]
GO
ALTER TABLE [kyc].[kyc_risk_analysis_response_test]  WITH CHECK ADD  CONSTRAINT [FKf88wk4ngc83x3mc2xawmo0uk4] FOREIGN KEY([kyc_risk_score_response_id])
REFERENCES [kyc].[kyc_risk_score_response_test] ([kyc_risk_score_response_id])
GO
ALTER TABLE [kyc].[kyc_risk_analysis_response_test] CHECK CONSTRAINT [FKf88wk4ngc83x3mc2xawmo0uk4]
GO
/****** Object:  StoredProcedure [kyc].[day_0_scoring_customer_master_load_jkuae]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [kyc].[day_0_scoring_customer_master_load_jkuae]
AS 
BEGIN
  DECLARE customer_cursor CURSOR FOR
  SELECT 
    address1,
	address2,
	address3,
	age,
	annual_income,
	area_code,
	block_unblock_date,
	block_unblock_reason,
	block_unblock_user,
	branch,
	business_name,
	complex_org_structure_flag,
	corporate_dealing_with,
	corporate_nature,
	corporate_other_info,
	corporate_type,
	country,
	country_of_birth,
	country_of_incorporation,
	customer_code,
	customer_type,
	date_of_incorporation,
	delivery_channel,
	dnfbp_dpms_flag,
	dob,
	email_id,
	employee_flag,
	employer_name,
	employment_type,
	expected_annual_txn_cnt,
	expected_annual_txn_val,
	first_name,
	fla_user_name,
	full_name,
	gender,
	id_expiry_date,
	id_issue_date,
	id_issuing_country,
	id_issuing_state,
	id_number,
	id_reverse_number,
	id_scan_type,
	id_type,
	is_web_remit_user,
	judicial_sector,
	last_name,
	legal_status,
	middle_name,
	mobile_number,
	mobile_number2,
	mode_of_cus_reg,
	nationality,
	nature_of_business,
	pep,
	phone1,
	place_of_birth,
	products_services,
	prof_level,
	profession,
	profile_created_date,
	profile_last_modified_date,
	residency_type,
	restrict_applied_by,
	restrict_created_dt,
	restrict_updated_by,
	restrict_updated_dt,
	source_of_income,
	state,
	trade_license_number,
	transaction_type,
	user_updated_id,
	visa_type,
	risk_band,
	risk_score,
	trxn_type
  FROM kyc.kyc.customer_master_staging;

  OPEN customer_cursor;

  DECLARE @address1 NVARCHAR(1000),
	@address2 NVARCHAR(1000),
	@address3 NVARCHAR(1000),
	@age NVARCHAR(1000),
	@annual_income NVARCHAR(1000),
	@area_code NVARCHAR(1000),
	@block_unblock_date NVARCHAR(1000),
	@block_unblock_reason NVARCHAR(1000),
	@block_unblock_user NVARCHAR(1000),
	@branch NVARCHAR(1000),
	@business_name NVARCHAR(1000),
	@complex_org_structure_flag NVARCHAR(1000),
	@corporate_dealing_with NVARCHAR(1000),
	@corporate_nature NVARCHAR(1000),
	@corporate_other_info NVARCHAR(1000),
	@corporate_type NVARCHAR(1000),
	@country NVARCHAR(1000),
	@country_of_birth NVARCHAR(1000),
	@country_of_incorporation NVARCHAR(1000),
	@customer_code NVARCHAR(1000),
	@customer_type NVARCHAR(1000),
	@date_of_incorporation NVARCHAR(1000),
	@delivery_channel NVARCHAR(1000),
	@dnfbp_dpms_flag NVARCHAR(1000),
	@dob NVARCHAR(1000),
	@email_id NVARCHAR(1000),
	@employee_flag NVARCHAR(1000),
	@employer_name NVARCHAR(1000),
	@employment_type NVARCHAR(1000),
	@expected_annual_txn_cnt NVARCHAR(1000),
	@expected_annual_txn_val NVARCHAR(1000),
	@first_name NVARCHAR(1000),
	@fla_user_name NVARCHAR(1000),
	@full_name NVARCHAR(1000),
	@gender NVARCHAR(1000),
	@id_expiry_date NVARCHAR(1000),
	@id_issue_date NVARCHAR(1000),
	@id_issuing_country NVARCHAR(1000),
	@id_issuing_state NVARCHAR(1000),
	@id_number NVARCHAR(1000),
	@id_reverse_number NVARCHAR(1000),
	@id_scan_type NVARCHAR(1000),
	@id_type NVARCHAR(1000),
	@is_web_remit_user NVARCHAR(1000),
	@judicial_sector NVARCHAR(1000),
	@last_name NVARCHAR(1000),
	@legal_status NVARCHAR(1000),
	@middle_name NVARCHAR(1000),
	@mobile_number NVARCHAR(1000),
	@mobile_number2 NVARCHAR(1000),
	@mode_of_cus_reg NVARCHAR(1000),
	@nationality NVARCHAR(1000),
	@nature_of_business NVARCHAR(1000),
	@pep NVARCHAR(1000),
	@phone1 NVARCHAR(1000),
	@place_of_birth NVARCHAR(1000),
	@products_services NVARCHAR(1000),
	@prof_level NVARCHAR(1000),
	@profession NVARCHAR(1000),
	@profile_created_date NVARCHAR(1000),
	@profile_last_modified_date NVARCHAR(1000),
	@residency_type NVARCHAR(1000),
	@restrict_applied_by NVARCHAR(1000),
	@restrict_created_dt NVARCHAR(1000),
	@restrict_updated_by NVARCHAR(1000),
	@restrict_updated_dt NVARCHAR(1000),
	@source_of_income NVARCHAR(1000),
	@state NVARCHAR(1000),
	@trade_license_number NVARCHAR(1000),
	@transaction_type NVARCHAR(1000),
	@user_updated_id NVARCHAR(1000),
	@visa_type NVARCHAR(1000),
	@risk_band NVARCHAR(1000),
	@risk_score NVARCHAR(1000),
	@trxn_type NVARCHAR(1000);

  WHILE @@FETCH_STATUS = 0
  BEGIN
	DECLARE @CUST_KEY INT;
	SET @CUST_KEY = NEXT VALUE FOR dev_casemgmt.dbo.customerMasterSeq;

	FETCH NEXT FROM customer_cursor
  INTO @address1,
	@address2,
	@address3,
	@age,
	@annual_income,
	@area_code,
	@block_unblock_date,
	@block_unblock_reason,
	@block_unblock_user,
	@branch,
	@business_name,
	@complex_org_structure_flag,
	@corporate_dealing_with,
	@corporate_nature,
	@corporate_other_info,
	@corporate_type,
	@country,
	@country_of_birth,
	@country_of_incorporation,
	@customer_code,
	@customer_type,
	@date_of_incorporation,
	@delivery_channel,
	@dnfbp_dpms_flag,
	@dob,
	@email_id,
	@employee_flag,
	@employer_name,
	@employment_type,
	@expected_annual_txn_cnt,
	@expected_annual_txn_val,
	@first_name,
	@fla_user_name,
	@full_name,
	@gender,
	@id_expiry_date,
	@id_issue_date,
	@id_issuing_country,
	@id_issuing_state,
	@id_number,
	@id_reverse_number,
	@id_scan_type,
	@id_type,
	@is_web_remit_user,
	@judicial_sector,
	@last_name,
	@legal_status,
	@middle_name,
	@mobile_number,
	@mobile_number2,
	@mode_of_cus_reg,
	@nationality,
	@nature_of_business,
	@pep,
	@phone1,
	@place_of_birth,
	@products_services,
	@prof_level,
	@profession,
	@profile_created_date,
	@profile_last_modified_date,
	@residency_type,
	@restrict_applied_by,
	@restrict_created_dt,
	@restrict_updated_by,
	@restrict_updated_dt,
	@source_of_income,
	@state,
	@trade_license_number,
	@transaction_type,
	@user_updated_id,
	@visa_type,
	@risk_band,
	@risk_score,
	@trxn_type;

    IF @customer_type = 'individual'
    BEGIN
	    DECLARE @DOB_DATETIME2 DATETIME2;
		DECLARE @YEAR_OF_BIRTH INT;
		
		BEGIN TRY
			SET @DOB_DATETIME2 = TRY_CAST(@DOB AS DATETIME2);
		END TRY
		BEGIN CATCH
			SET @DOB_DATETIME2 = NULL;
		END CATCH
		
		IF CAST(@DOB_DATETIME2 AS DATE) = '1900-01-01'
		BEGIN
		  SET @DOB_DATETIME2 = NULL;
		END;
		ELSE
		BEGIN
		  SET @YEAR_OF_BIRTH = YEAR(CAST(@DOB_DATETIME2 AS DATE));
		END;
		IF CAST(@ID_ISSUE_DATE AS DATE) = '1900-01-01'
		BEGIN
		  SET @ID_ISSUE_DATE = NULL;
		END;
		IF CAST(@ID_EXPIRY_DATE AS DATE) = '1900-01-01'
		BEGIN
		  SET @ID_EXPIRY_DATE = NULL;
		END;

      INSERT INTO dev_casemgmt.dbo.CUSTOMER_MASTER (
            CUST_KEY,
            SEGMENT_ID,
            CUST_NUM,
            CUST_TYPE,
            CUST_IDENTI_ID,
            CUST_IDENTI_TYPE_DETAIL,
            CUST_ID_STATE_CODE,
            CUST_DOB,
            CUST_FIRST_NAME,
            CUST_LAST_NAME,
            CUST_MIDDLE_NAME,
            CUST_NAME,
            LOCALITY_ADDRESS_1,
            LOCALITY_ADDRESS_2,
            LOCALITY_STATE_NAME,
            LOCALITY_POSTAL_CODE,
            LOCALITY_COUNTRY_NAME,
            SENDING_MAIL_ADDRESS_1,
            RESIDENCE_COUNTRY_NAME,
            CITIZENSHIP_COUNTRY_NAME,
            EMPLOYER_NAME,
            EMAIL_ID,
            OCCUPATION_INFORMATION,
            IMMEDIATE_PARENT_NAME,
            CONTACT_NUM_1,
            CONTACT_NUM_2,
            CONTACT_NUM_3,
            ANNUAL_INCOME_VALUE,
            IS_POLITICALLY_EXPOSED_PERSON,
            CREATED_BY,
            EMPLOYEE_FLAG,
            RISK_BAND_ONB,
            RISK_SCORE_ONB,
            EXPECTED_ANNUAL_VALUE,
            EXPECTED_ANNUAL_COUNT,
            CUST_AGE,
            CUST_ID_EXPIRY_DATE,
            CUST_ID_ISSUE_DATE,
            GENDER,
			BRANCH,
            VISA_TYPE,
            SOURCE_OF_INCOME,
            PLACE_OF_BIRTH,
            EMPLOYMENT_TYPE,
            DELIVERY_CHANNEL,
            PROFILE_CREATED_DATE,
            PROFILE_LAST_MODIFIED_DATE,
            BLOCK_UNBLOCK_REASON,
            BLOCK_UNBLOCK_USER,
            BLOCK_UNBLOCK_DATE,
            IS_WEB_REMIT_USER,
            MODE_OF_CUS_REG,
            LOCALITY_ADDRESS_3,
            USER_UPDATED_ID,
            CUST_ID_COUNTRY,
            ID_REVERSE_NUMBER,
            ID_SCAN_TYPE,
            TRANSACTION_TYPE,
            RESTRICT_UPDATED_BY,
            RESTRICT_CREATED_DT,
            RESTRICT_APPLIED_BY,
            RESTRICT_UPDATED_DT,
            CREATED_DT,
            UPDATED_DT,
            ALTER_PRESENT_IND,
            UPDATED_BY,
            YEAR_OF_BIRTH 
        )
        VALUES (
            @CUST_KEY,
            @CUSTOMER_TYPE,
            @CUSTOMER_CODE,
            @CUSTOMER_TYPE,
            @ID_NUMBER,
            @ID_TYPE,
            @ID_ISSUING_STATE,
            @DOB_DATETIME2,
            @FIRST_NAME,
            @LAST_NAME,
            @MIDDLE_NAME,
            @FULL_NAME,
            @ADDRESS1,
            @ADDRESS2,
            @STATE,
            @AREA_CODE,
            @COUNTRY,
            @RESIDENCY_TYPE,
            @COUNTRY_OF_BIRTH,
            @NATIONALITY,
            @EMPLOYER_NAME,
            @EMAIL_ID,
            @PROFESSION,
            @PROF_LEVEL,
            @MOBILE_NUMBER,
            @PHONE1,
            @MOBILE_NUMBER2,
            @ANNUAL_INCOME,
            @PEP,
            @FLA_USER_NAME,
            @EMPLOYEE_FLAG,
            @RISK_BAND,
            @RISK_SCORE,
            @EXPECTED_ANNUAL_TXN_VAL,
            @EXPECTED_ANNUAL_TXN_CNT,
            @AGE,
            @ID_EXPIRY_DATE,
            @ID_ISSUE_DATE,
            @GENDER,
            @BRANCH,
            @VISA_TYPE,
            @SOURCE_OF_INCOME,
            @PLACE_OF_BIRTH,
            @EMPLOYMENT_TYPE,
            @DELIVERY_CHANNEL,
            @PROFILE_CREATED_DATE,
            @PROFILE_LAST_MODIFIED_DATE,
            @BLOCK_UNBLOCK_REASON,
            @BLOCK_UNBLOCK_USER,
           	@BLOCK_UNBLOCK_DATE,
            @IS_WEB_REMIT_USER,
            @MODE_OF_CUS_REG,
            @ADDRESS3,
            @USER_UPDATED_ID,
            @ID_ISSUING_COUNTRY,
            @ID_REVERSE_NUMBER,
            @ID_SCAN_TYPE,
            @TRANSACTION_TYPE,
            @RESTRICT_UPDATED_BY,
            @RESTRICT_CREATED_DT,
            @RESTRICT_APPLIED_BY,
            @RESTRICT_UPDATED_DT,
            GETDATE(),
            GETDATE(),
            'N',
            'Admin',
            @YEAR_OF_BIRTH
        );
    END
    ELSE IF @customer_type = 'corporate'
    BEGIN
	    
	    DECLARE @INCORPORATION_DATE_DATETIME DATETIME2;
		
		BEGIN TRY
			SET @INCORPORATION_DATE_DATETIME = TRY_CAST(@date_of_incorporation AS DATETIME2);
		END TRY
		BEGIN CATCH
			SET @INCORPORATION_DATE_DATETIME = NULL;
		END CATCH
		
		IF CAST(@INCORPORATION_DATE_DATETIME AS DATE) = '1900-01-01'
		BEGIN
		  SET @INCORPORATION_DATE_DATETIME = NULL;
		END;
		ELSE
		BEGIN
		  SET @YEAR_OF_BIRTH = YEAR(CAST(@INCORPORATION_DATE_DATETIME AS DATE));
		END;
		IF CAST(@ID_ISSUE_DATE AS DATE) = '1900-01-01'
		BEGIN
		  SET @ID_ISSUE_DATE = NULL;
		END;
		IF CAST(@ID_EXPIRY_DATE AS DATE) = '1900-01-01'
		BEGIN
		  SET @ID_EXPIRY_DATE = NULL;
		END;

      INSERT INTO dev_casemgmt.dbo.CUSTOMER_MASTER (
        CUST_KEY,
        SEGMENT_ID,
        CUST_NUM,
        CUST_TYPE,
        CUST_IDENTI_ID,
        CUST_IDENTI_TYPE_DETAIL,
        CUST_ID_STATE_CODE,
        CREATED_DATE,
        CUST_NAME,
        LOCALITY_ADDRESS_1,
        LOCALITY_ADDRESS_2,
        LOCALITY_STATE_NAME,
        EMAIL_ID,
     	CUST_TAX_ID,
        BUSINESS_INDUSTRY_DESC,
        CONTACT_NUM_1,
        CREATED_BY,
        RISK_BAND_ONB,
        RISK_SCORE_ONB,
        EXPECTED_ANNUAL_VALUE,
        EXPECTED_ANNUAL_COUNT,
        CUST_ID_EXPIRY_DATE,
        CUST_ID_ISSUE_DATE,
        BRANCH,
        PROFILE_CREATED_DATE,
        PROFILE_LAST_MODIFIED_DATE,
        BLOCK_UNBLOCK_REASON,
        BLOCK_UNBLOCK_USER,
        BLOCK_UNBLOCK_DATE,
        IS_WEB_REMIT_USER,
        MODE_OF_CUS_REG,
        LOCALITY_ADDRESS_3,
        USER_UPDATED_ID,
        CUST_ID_COUNTRY,
        ID_REVERSE_NUMBER,
        ID_SCAN_TYPE,
        TRANSACTION_TYPE,
        RESTRICT_UPDATED_BY,
        RESTRICT_CREATED_DT,
        RESTRICT_APPLIED_BY,
        RESTRICT_UPDATED_DT,
        DOING_BUSINESS_WITH_NAME,
		CODE_ORGANISATION,
		LOCALITY_COUNTRY_NAME,
		PRIMARY_COUNTRY_BUSNS_NAME,
		BUSINESS_INDUSTRY_CODE,
		DNFBP_FLAG,
		PRODUCTS_SERVICES,
		NATURE_OF_BUSINESS,
		JUDICIAL_SECTOR,
		LEGAL_STATUS,
		CREATED_DT,
        UPDATED_DT,
        ALTER_PRESENT_IND,
        UPDATED_BY,
        YEAR_OF_BIRTH 
    )
    VALUES (
        @CUST_KEY,
        @CUSTOMER_TYPE,
        @CUSTOMER_CODE,
        @CUSTOMER_TYPE,
        @TRADE_LICENSE_NUMBER,
        @ID_TYPE,
        @ID_ISSUING_STATE,
        @INCORPORATION_DATE_DATETIME,
        @BUSINESS_NAME,
        @ADDRESS1,
        @ADDRESS2,
        @STATE,
        @EMAIL_ID,
        @CORPORATE_OTHER_INFO,
        @CORPORATE_NATURE,
        @MOBILE_NUMBER,
        @FLA_USER_NAME,
        @RISK_BAND,
        @RISK_SCORE,
        @EXPECTED_ANNUAL_TXN_VAL,
        @EXPECTED_ANNUAL_TXN_CNT,
        @ID_EXPIRY_DATE,
        @ID_ISSUE_DATE,
        @BRANCH,
        @PROFILE_CREATED_DATE,
        @PROFILE_LAST_MODIFIED_DATE,
        @BLOCK_UNBLOCK_REASON,
        @BLOCK_UNBLOCK_USER,
        @BLOCK_UNBLOCK_DATE,
		@IS_WEB_REMIT_USER,
		@MODE_OF_CUS_REG,
  		@ADDRESS3,
        @USER_UPDATED_ID,
        @ID_ISSUING_COUNTRY,
        @ID_REVERSE_NUMBER,
        @ID_SCAN_TYPE,
        @TRANSACTION_TYPE,
        @RESTRICT_UPDATED_BY,
        @RESTRICT_CREATED_DT,
        @RESTRICT_APPLIED_BY,
        @RESTRICT_UPDATED_DT,
        @CORPORATE_DEALING_WITH,
        @country_of_incorporation,
        @COUNTRY,
        @COMPLEX_ORG_STRUCTURE_FLAG,
        @CORPORATE_TYPE,
        @DNFBP_DPMS_FLAG,
        @PRODUCTS_SERVICES,
		@NATURE_OF_BUSINESS,
		@JUDICIAL_SECTOR,
		@LEGAL_STATUS,
		GETDATE(),
        GETDATE(),
        'N',
        'Admin',
        @YEAR_OF_BIRTH
        );
    END
  END

  CLOSE customer_cursor;
  DEALLOCATE customer_cursor;
END;
GO
/****** Object:  StoredProcedure [kyc].[day_0_scoring_customer_stakeholder_master_load_jkuae]    Script Date: 20-Jun-25 1:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [kyc].[day_0_scoring_customer_stakeholder_master_load_jkuae]
AS 
BEGIN
  DECLARE customer_cursor CURSOR FOR
  SELECT 
    CUSTOMER_CODE,
	NAME,
	TYPE,
	NATIONALITY,
	DOB,
	RESIDENCY,
	SHARE_PERCENT,
	ID_NUMBER,
	ID_EXPIRY_DATE,
	UB_FLAG,
	IS_PEP,
	IS_AUTH_SIGNATORY,
	IS_PRIMARY,
	TYPE_OF_ENTRY
  FROM kyc.kyc.stakeholder_master_staging;

  OPEN customer_cursor;

  DECLARE @cust_num NVARCHAR(1000),
	@name NVARCHAR(1000),
	@type NVARCHAR(1000),
	@nationality NVARCHAR(1000),
	@dob NVARCHAR(1000),
	@residency NVARCHAR(1000),
	@share_percent NVARCHAR(1000),
	@id_number NVARCHAR(1000),
	@id_expiry_date NVARCHAR(1000),
	@ub_flag NVARCHAR(1000),
	@is_pep NVARCHAR(1000),
	@is_auth_signatory NVARCHAR(1000),
	@is_primary NVARCHAR(1000),
	@type_of_entry NVARCHAR(1000);

  WHILE @@FETCH_STATUS = 0
  BEGIN
	DECLARE @STAKEHOLDER_ID INT;
	SET @STAKEHOLDER_ID = NEXT VALUE FOR dev_casemgmt.dbo.customerStakeholderMasterSeq;
    
	FETCH NEXT FROM customer_cursor
  	INTO @cust_num,
	@name,
	@type,
	@nationality,
	@dob,
	@residency,
	@share_percent,
	@id_number,
	@id_expiry_date,
	@ub_flag,
	@is_pep,
	@is_auth_signatory,
	@is_primary,
	@type_of_entry;

	DECLARE @DOB_DATETIME2 DATETIME2;
	DECLARE @ID_EXPIRY_DATE_DATETIME2 DATETIME2;
	
	BEGIN TRY
		SET @DOB_DATETIME2 = TRY_CAST(@DOB AS DATETIME2);
	END TRY
	BEGIN CATCH
		SET @DOB_DATETIME2 = NULL;
	END CATCH
	
	IF CAST(@DOB_DATETIME2 AS DATE) = '1900-01-01'
	BEGIN
	  SET @DOB_DATETIME2 = NULL;
	END;

	BEGIN TRY
		SET @ID_EXPIRY_DATE_DATETIME2 = TRY_CAST(@ID_EXPIRY_DATE AS DATETIME2);
	END TRY
	BEGIN CATCH
		SET @ID_EXPIRY_DATE_DATETIME2 = NULL;
	END CATCH
	
	IF CAST(@ID_EXPIRY_DATE_DATETIME2 AS DATE) = '1900-01-01'
	BEGIN
	  SET @ID_EXPIRY_DATE_DATETIME2 = NULL;
	END;

  INSERT INTO dev_casemgmt.dbo.CUSTOMER_STAKEHOLDER_MASTER (
  		STAKEHOLDER_ID,
        CUST_NUM,
		NAME,
		TYPE,
		NATIONALITY,
		DOB,
		RESIDENCY,
		SHARE_PERCENT,
		ID_NUMBER,
		ID_EXPIRY_DATE,
		UB_FLAG,
		IS_PEP,
		IS_AUTH_SIGNATORY,
		IS_PRIMARY,
		TYPE_OF_ENTRY,
		UPDATED_DT
    )
    VALUES (
    	@STAKEHOLDER_ID,
        @cust_num,
		@name,
		@type,
		@nationality,
		@dob_datetime2,
		@residency,
		@share_percent,
		@id_number,
		@id_expiry_date_datetime2,
		@ub_flag,
		@is_pep,
		@is_auth_signatory,
		@is_primary,
		@type_of_entry,
		GETDATE()
    );
  END

  CLOSE customer_cursor;
  DEALLOCATE customer_cursor;
END;
GO
