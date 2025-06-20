USE [dev_sanctions]
GO
/****** Object:  User [dev_casemgmt]    Script Date: 20-Jun-25 1:12:15 AM ******/
CREATE USER [dev_casemgmt] FOR LOGIN [dev_casemgmt] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dev_cmsvi_user]    Script Date: 20-Jun-25 1:12:15 AM ******/
CREATE USER [dev_cmsvi_user] FOR LOGIN [dev_cmsvi_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [dev_sanctions]    Script Date: 20-Jun-25 1:12:15 AM ******/
CREATE USER [dev_sanctions] FOR LOGIN [dev_sanctions] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [kyc_user]    Script Date: 20-Jun-25 1:12:15 AM ******/
CREATE USER [kyc_user] FOR LOGIN [kyc_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [uat_core_exchange]    Script Date: 20-Jun-25 1:12:15 AM ******/
CREATE USER [uat_core_exchange] FOR LOGIN [uat_core_exchange] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [dev_casemgmt]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dev_cmsvi_user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dev_cmsvi_user]
GO
ALTER ROLE [db_owner] ADD MEMBER [dev_sanctions]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dev_sanctions]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dev_sanctions]
GO
ALTER ROLE [db_owner] ADD MEMBER [kyc_user]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [kyc_user]
GO
ALTER ROLE [db_datareader] ADD MEMBER [kyc_user]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [kyc_user]
GO
/****** Object:  UserDefinedFunction [dbo].[countData]    Script Date: 20-Jun-25 1:12:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[countData]
(
    @create_dttm varchar(250),
	@finish_dttm varchar(250)
)
RETURNS varchar(250)
AS
 
BEGIN
 
    
    -- write code here
    --select distinct match_identifier,x.status_desc from dev_sanctions.dbo.score_mapping_transaction t , dev_sanctions.dbo.sanction_transaction_response x
--where t.response_sno=x.response_sno and x.response_sno=265
 
 
 
   RETURN (select count(*) from LIST_DATA_WCHT where 
  -- UPDATED_DTTM>=SUBSTRING(@create_dttm,0,20)and
   UPDATED_DTTM<=SUBSTRING(@finish_dttm,0,20))
 
 
 
END
GO
/****** Object:  Table [dbo].[incremental_refresh_audit]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incremental_refresh_audit](
	[id] [int] NOT NULL,
	[file_generated_date] [datetime2](7) NULL,
	[file_name] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[load_complete_dttm] [datetime2](7) NULL,
	[loaded_cnt] [varchar](255) NULL,
	[process_dttm] [datetime2](7) NULL,
	[status] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[request_master]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[request_master](
	[request_id] [bigint] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[category] [varchar](255) NULL,
	[changes_applied] [bit] NULL,
	[checker_comment] [varchar](3500) NULL,
	[data] [varchar](255) NULL,
	[entity_ref] [bigint] NULL,
	[list_name] [varchar](255) NULL,
	[list_sub_type] [varchar](255) NULL,
	[list_type] [varchar](255) NULL,
	[maker_comment] [varchar](3500) NULL,
	[request_for] [varchar](255) NULL,
	[request_status] [varchar](255) NULL,
	[request_type] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[untm_update_flg] [varchar](255) NULL,
	[update_diff] [varchar](max) NULL,
	[upload_for_existing] [bit] NULL,
	[list_master_id] [bigint] NULL,
	[expiry_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_request]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_request](
	[list_request_sno] [int] NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL,
	[request_id] [bigint] NULL,
	[expiry_date] [datetime] NULL,
 CONSTRAINT [PK__list_dat__BC48EB556F0086E8] PRIMARY KEY CLUSTERED 
(
	[list_request_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ListUploadView]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListUploadView] AS
select
	rm.created_by,
	rm.created_dttm as load_complete_dttm,
	rm.list_name,
	rm.list_type,
	rm.list_sub_type,
	rm.created_dttm as file_generated_dttm,
	null as file_name,
	rm.created_dttm as process_dttm,
	crm.loaded_cnt,
	rm.request_status	
from
	request_master rm
join (select request_id,count(request_id) as loaded_cnt from list_data_request ldr group by request_id) crm on
	rm.request_id = crm.request_id
where
	rm.request_for = 'list_master'
	and rm.request_type = 'Upload'
UNION ALL
select
	'Automated Scheduler' as created_by,
	load_Complete_dttm,
	list_name,
	'Black_List' as list_type,
	'Reg List' as list_sub_type,
	file_generated_date as file_generated_dttm,
	file_name,
	process_dttm,
	loaded_cnt,
	'Fail' as status
from
	incremental_refresh_audit ira
	where status =-1
UNION ALL
select
	'Automated Scheduler' as created_by,
	load_Complete_dttm,
	list_name,
	'Black_List' as list_type,
	'Reg List' as list_sub_type,
	file_generated_date as file_generated_dttm,
	file_name,
	process_dttm,
	loaded_cnt,
	'Success' as status
from
	incremental_refresh_audit ira
	where status =0
	
GO
/****** Object:  Table [dbo].[common_file_upload_request]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[common_file_upload_request](
	[upload_request_no] [bigint] NOT NULL,
	[code] [varchar](255) NULL,
	[name] [varchar](255) NULL,
	[request_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[upload_request_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuration_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[configuration_table](
	[rule_number] [int] NOT NULL,
	[txn_type] [nvarchar](250) NULL,
	[threshold1] [nvarchar](250) NULL,
	[threshold_1_definition] [nvarchar](250) NULL,
	[threshold2] [nvarchar](250) NULL,
	[threshold_2_definition] [nvarchar](250) NULL,
	[threshold3] [nvarchar](250) NULL,
	[threshold_3_definition] [nvarchar](250) NULL,
	[lookback_period_in_days] [nvarchar](250) NULL,
	[status] [nvarchar](250) NULL,
 CONSTRAINT [PK_configuration_table] PRIMARY KEY CLUSTERED 
(
	[rule_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[id] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[country_code] [varchar](255) NULL,
	[country_name] [varchar](255) NULL,
	[request_ref] [bigint] NULL,
	[untm_update_flg] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country_code_name_mapping]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_code_name_mapping](
	[country_name] [nvarchar](100) NULL,
	[country_code] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country_code_nationality_mapping]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_code_nationality_mapping](
	[country_code] [nvarchar](50) NULL,
	[country_name] [nvarchar](100) NULL,
	[country_nationality] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country_currency]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_currency](
	[country_name] [varchar](100) NULL,
	[currency_code] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country_nationality_code_mapping]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_nationality_code_mapping](
	[country_nationality] [nvarchar](100) NULL,
	[country_code] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[country_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country_table](
	[country_code] [nvarchar](50) NULL,
	[risk] [nvarchar](50) NULL,
	[sanctioned_flag] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_table](
	[cust_number] [bigint] NOT NULL,
	[Created_dttm] [nvarchar](250) NULL,
	[Update_dttm] [nvarchar](250) NULL,
	[Cust_type] [nvarchar](250) NULL,
	[cust_first_name] [nvarchar](250) NULL,
	[cust_middle_name] [nvarchar](250) NULL,
	[cust_first_name2] [nvarchar](250) NULL,
	[cust_residency_status] [nvarchar](250) NULL,
	[cust_onboarding_risk_score] [nvarchar](250) NULL,
	[cust_ongoing_risk_score] [nvarchar](250) NULL,
	[sanctions_match] [nvarchar](250) NULL,
	[customer_onboarding_risk_band] [nvarchar](250) NULL,
	[customer_ongoing_risk_band] [nvarchar](250) NULL,
	[acc_dormancy_date] [nvarchar](250) NULL,
	[dormancy_flag] [nvarchar](250) NULL,
	[age] [nvarchar](250) NULL,
	[pep_flag] [nvarchar](250) NULL,
	[low2high_flag] [nvarchar](250) NULL,
	[dnfbp_dpms_flag] [nvarchar](250) NULL,
	[third_party_flag] [nvarchar](250) NULL,
	[LM_emp_flag] [nvarchar](250) NULL,
	[exp_out_yearly_freq] [nvarchar](250) NULL,
	[exp_out_yearly_value] [nvarchar](250) NULL,
	[Resident_type] [nvarchar](250) NULL,
	[ID_type] [nvarchar](250) NULL,
	[Nationality] [nvarchar](250) NULL,
	[birth_country] [nvarchar](250) NULL,
	[profession] [nvarchar](250) NULL,
	[EID_expiry_date] [nvarchar](250) NULL,
	[PEP] [nvarchar](250) NULL,
	[Products] [nvarchar](250) NULL,
	[ID_issuing_country] [nvarchar](250) NULL,
	[incorporation_country] [nvarchar](250) NULL,
	[Nature_of_business] [nvarchar](250) NULL,
	[Legal_status] [nvarchar](250) NULL,
	[Judicial_sector] [nvarchar](250) NULL,
	[Registration_date] [nvarchar](250) NULL,
	[incorporation_juris] [nvarchar](250) NULL,
	[Organisation_structure] [nvarchar](250) NULL,
	[stakeholders_pep] [nvarchar](250) NULL,
	[stakeholders_nationality] [nvarchar](250) NULL,
	[DNFBPs_DPMS] [nvarchar](250) NULL,
	[time_from_dormancy] [nvarchar](250) NULL,
 CONSTRAINT [PK_customer_table] PRIMARY KEY CLUSTERED 
(
	[cust_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[delete_data_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delete_data_temp](
	[uid] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[delta_audit_master]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delta_audit_master](
	[id] [bigint] NOT NULL,
	[average_screening_time] [varchar](255) NULL,
	[data_load_cnt] [int] NULL,
	[match_found_count] [int] NULL,
	[screening_end_time] [datetime2](7) NULL,
	[screening_start_time] [datetime2](7) NULL,
	[screening_status] [int] NULL,
	[thread_count] [int] NULL,
	[total_records_screened] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[delta_customer_data]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delta_customer_data](
	[request_sno] [int] NOT NULL,
	[country] [varchar](255) NULL,
	[customer_name] [varchar](255) NULL,
	[customer_number] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[onboarding_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[request_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[delta_screening_response]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delta_screening_response](
	[response_sno] [int] NOT NULL,
	[entity_watch_list_key] [bigint] NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[list_cat] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[name_in_eng] [varchar](255) NULL,
	[score] [float] NULL,
	[type_desc] [varchar](255) NULL,
	[watchlist_name] [varchar](255) NULL,
	[year_of_birth] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[response_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[demo_dm]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[demo_dm](
	[id] [int] NULL,
	[DM_ENCODE] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[demo_ny]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[demo_ny](
	[id] [int] NULL,
	[NY_ENCODE] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_details_master_archive]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_details_master_archive](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[address_line] [varchar](255) NULL,
	[address_city] [varchar](255) NULL,
	[address_country] [varchar](255) NULL,
	[url] [varchar](255) NULL,
	[country_type] [varchar](255) NULL,
	[country_code] [varchar](255) NULL,
	[country_name] [varchar](255) NULL,
	[id_type] [varchar](255) NULL,
	[id_value] [varchar](255) NULL,
	[id_notes] [varchar](255) NULL,
	[image_url] [varchar](255) NULL,
	[role_type] [varchar](255) NULL,
	[occ_category] [varchar](255) NULL,
	[occ_title] [varchar](255) NULL,
	[since_day] [varchar](255) NULL,
	[since_month] [varchar](255) NULL,
	[since_year] [varchar](255) NULL,
	[to_day] [varchar](255) NULL,
	[to_month] [varchar](255) NULL,
	[to_year] [varchar](255) NULL,
	[reference_name] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_details_master_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_details_master_temp](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[address_line] [varchar](255) NULL,
	[address_city] [varchar](255) NULL,
	[address_country] [varchar](255) NULL,
	[url] [varchar](255) NULL,
	[country_type] [varchar](255) NULL,
	[country_code] [varchar](255) NULL,
	[country_name] [varchar](255) NULL,
	[id_type] [varchar](255) NULL,
	[id_value] [varchar](255) NULL,
	[id_notes] [varchar](255) NULL,
	[image_url] [varchar](255) NULL,
	[role_type] [varchar](255) NULL,
	[occ_category] [varchar](255) NULL,
	[occ_title] [varchar](255) NULL,
	[since_day] [varchar](255) NULL,
	[since_month] [varchar](255) NULL,
	[since_year] [varchar](255) NULL,
	[to_day] [varchar](255) NULL,
	[to_month] [varchar](255) NULL,
	[to_year] [varchar](255) NULL,
	[reference_name] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_incremental_refresh_audit]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_incremental_refresh_audit](
	[id] [int] NOT NULL,
	[file_generated_date] [datetime2](7) NULL,
	[file_name] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[load_complete_dttm] [datetime2](7) NULL,
	[loaded_cnt] [varchar](255) NULL,
	[process_dttm] [datetime2](7) NULL,
	[status] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_list_data_wcht]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_list_data_wcht](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_list_data_wcht_archive]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_list_data_wcht_archive](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[entity_ref] [varchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_list_data_wcht_del_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_list_data_wcht_del_temp](
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[id] [numeric](12, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dow_jones_list_data_wcht_incr_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dow_jones_list_data_wcht_incr_temp](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](4000) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](2000) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](2000) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](4000) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](255) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](8000) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dow_Jones_Sanctions_Reference_List]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dow_Jones_Sanctions_Reference_List](
	[id] [numeric](12, 0) NOT NULL,
	[reference_name] [varchar](1000) NULL,
	[status] [varchar](255) NULL,
	[description_2_id] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_address]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_address](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[address_line] [varchar](255) NULL,
	[address_city] [varchar](255) NULL,
	[address_country] [varchar](255) NULL,
	[url] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_country_details]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_country_details](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[country_type] [varchar](255) NULL,
	[country_code] [varchar](255) NULL,
	[country_name] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_id_details]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_id_details](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[id_type] [varchar](255) NULL,
	[id_value] [varchar](255) NULL,
	[id_notes] [nvarchar](max) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_image]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_image](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[image_url] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_lookup_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_lookup_table](
	[id] [numeric](12, 0) NOT NULL,
	[type_desc] [varchar](255) NULL,
	[lookup_name] [varchar](255) NULL,
	[lookup_code] [varchar](255) NULL,
	[lookup_value] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[description1Id] [varchar](255) NULL,
	[description2Id] [varchar](255) NULL,
	[description3Id] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_role_type]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_role_type](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[role_type] [varchar](255) NULL,
	[occ_category] [varchar](255) NULL,
	[occ_title] [varchar](255) NULL,
	[since_day] [varchar](255) NULL,
	[since_month] [varchar](255) NULL,
	[since_year] [varchar](255) NULL,
	[to_day] [varchar](255) NULL,
	[to_month] [varchar](255) NULL,
	[to_year] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_sanctions]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_sanctions](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[reference_name] [varchar](255) NULL,
	[since_day] [varchar](255) NULL,
	[since_month] [varchar](255) NULL,
	[since_year] [varchar](255) NULL,
	[to_day] [varchar](255) NULL,
	[to_month] [varchar](255) NULL,
	[to_year] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dowjones_source_description]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dowjones_source_description](
	[id] [numeric](12, 0) NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EBIX_WORLD_CHECK]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EBIX_WORLD_CHECK](
	[UID] [numeric](12, 0) NOT NULL,
	[LAST_NAME] [varchar](4000) NULL,
	[FIRST_NAME] [varchar](4000) NULL,
	[ALIASES] [varchar](4000) NULL,
	[ALTERNATIVE_SPELLING] [varchar](4000) NULL,
	[CATEGORY] [varchar](4000) NULL,
	[TITLE] [varchar](4000) NULL,
	[SUB_CATEGORY] [varchar](4000) NULL,
	[POSITION] [varchar](4000) NULL,
	[AGE] [varchar](4000) NULL,
	[DOB] [varchar](4000) NULL,
	[DOBS] [varchar](4000) NULL,
	[PLACE_OF_BIRTH] [varchar](4000) NULL,
	[DECEASED] [varchar](4000) NULL,
	[PASSPORTS] [varchar](4000) NULL,
	[SSN] [varchar](4000) NULL,
	[IDENTIFICATION_NUMBERS] [varchar](4000) NULL,
	[LOCATIONS] [varchar](4000) NULL,
	[COUNTRIES] [varchar](4000) NULL,
	[CITIZENSHIP] [varchar](4000) NULL,
	[COMPANIES] [varchar](4000) NULL,
	[E_I] [varchar](4000) NULL,
	[LINKED_TO] [varchar](4000) NULL,
	[FURTHER_INFORMATION] [varchar](4000) NULL,
	[KEYWORDS] [varchar](4000) NULL,
	[EXTERNAL_SOURCES] [varchar](4000) NULL,
	[ENTERED] [varchar](4000) NULL,
	[UPDATED] [varchar](4000) NULL,
	[EDITOR] [varchar](4000) NULL,
	[AGE_DATE_AS_OF_DATE] [varchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entity_identification]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity_identification](
	[id] [int] NOT NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[entity_identification_guid] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[expiration_date] [varchar](255) NULL,
	[identification_issuer] [varchar](255) NULL,
	[identification_number] [varchar](255) NULL,
	[identification_type_desc] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[issue_date] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entity_list_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity_list_test](
	[entity_watch_list_number] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entity_list_test_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity_list_test_test](
	[entity_watch_list_number] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entity_list_wcht_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity_list_wcht_test](
	[entity_watch_list_number] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entity_list_wcht_test1]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity_list_wcht_test1](
	[entity_watch_list_number] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eu_extended]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eu_extended](
	[entity_designationdate] [varchar](1) NULL,
	[entity_designationdetails] [varchar](1) NULL,
	[namealias_namelanguage] [varchar](1) NULL,
	[namealias_gender] [varchar](1) NULL,
	[namealias_function] [varchar](1) NULL,
	[namealias_logicalid] [varchar](1) NULL,
	[namealias_regulationlanguage] [varchar](1) NULL,
	[namealias_regulation_type] [varchar](1) NULL,
	[namealias_regulation_organisationtype] [varchar](1) NULL,
	[namealias_regulation_publicationdate] [varchar](1) NULL,
	[namealias_regulation_entryintoforcedate] [varchar](1) NULL,
	[namealias_regulation_numbertitle] [varchar](1) NULL,
	[namealias_regulation_programme] [varchar](1) NULL,
	[namealias_regulation_publicationurl] [varchar](1) NULL,
	[address_pobox] [varchar](1) NULL,
	[address_asatlistingtime] [varchar](1) NULL,
	[address_logicalid] [varchar](1) NULL,
	[address_regulationlanguage] [varchar](1) NULL,
	[address_regulation_type] [varchar](1) NULL,
	[address_regulation_organisationtype] [varchar](1) NULL,
	[address_regulation_publicationdate] [varchar](1) NULL,
	[address_regulation_entryintoforcedate] [varchar](1) NULL,
	[address_regulation_numbertitle] [varchar](1) NULL,
	[address_regulation_programme] [varchar](1) NULL,
	[address_regulation_publicationurl] [varchar](1) NULL,
	[birthdate_day] [varchar](1) NULL,
	[birthdate_month] [varchar](1) NULL,
	[birthdate_yearrangefrom] [varchar](1) NULL,
	[birthdate_yearrangeto] [varchar](1) NULL,
	[birthdate_circa] [varchar](1) NULL,
	[birthdate_calendartype] [varchar](1) NULL,
	[birthdate_zipcode] [varchar](1) NULL,
	[birthdate_region] [varchar](1) NULL,
	[birthdate_countryiso2code] [varchar](1) NULL,
	[birthdate_logicalid] [varchar](1) NULL,
	[birthdate_regulationlanguage] [varchar](1) NULL,
	[birthdate_regulation_type] [varchar](1) NULL,
	[birthdate_regulation_organisationtype] [varchar](1) NULL,
	[birthdate_regulation_publicationdate] [varchar](1) NULL,
	[birthdate_regulation_entryintoforcedate] [varchar](1) NULL,
	[birthdate_regulation_numbertitle] [varchar](1) NULL,
	[birthdate_regulation_programme] [varchar](1) NULL,
	[birthdate_regulation_publicationurl] [varchar](1) NULL,
	[identification_diplomatic] [varchar](1) NULL,
	[identification_knownexpired] [varchar](1) NULL,
	[identification_knownfalse] [varchar](1) NULL,
	[identification_reportedlost] [varchar](1) NULL,
	[identification_revokedbyissuer] [varchar](1) NULL,
	[identification_issuedby] [varchar](1) NULL,
	[identification_issueddate] [varchar](1) NULL,
	[identification_validfrom] [varchar](1) NULL,
	[identification_validto] [varchar](1) NULL,
	[identification_latinnumber] [varchar](1) NULL,
	[identification_nameondocument] [varchar](1) NULL,
	[identification_typecode] [varchar](1) NULL,
	[identification_region] [varchar](1) NULL,
	[identification_countrydescription] [varchar](1) NULL,
	[identification_logicalid] [varchar](1) NULL,
	[identification_regulationlanguage] [varchar](1) NULL,
	[identification_regulation_type] [varchar](1) NULL,
	[identification_regulation_organisationtype] [varchar](1) NULL,
	[identification_regulation_publicationdate] [varchar](1) NULL,
	[identification_regulation_entryintoforcedate] [varchar](1) NULL,
	[identification_regulation_numbertitle] [varchar](1) NULL,
	[identification_regulation_programme] [varchar](1) NULL,
	[identification_regulation_publicationurl] [varchar](1) NULL,
	[citizenship_region] [varchar](1) NULL,
	[citizenship_logicalid] [varchar](1) NULL,
	[citizenship_regulationlanguage] [varchar](1) NULL,
	[citizenship_regulation_type] [varchar](1) NULL,
	[citizenship_regulation_organisationtype] [varchar](1) NULL,
	[citizenship_regulation_publicationdate] [varchar](1) NULL,
	[citizenship_regulation_entryintoforcedate] [varchar](1) NULL,
	[citizenship_regulation_numbertitle] [varchar](1) NULL,
	[citizenship_regulation_programme] [varchar](1) NULL,
	[citizenship_regulation_publicationurl] [varchar](1) NULL,
	[entity_regulation_logicalid] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[forex_txn_data]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forex_txn_data](
	[id] [bigint] NOT NULL,
	[transaction_ref_no] [varchar](100) NULL,
	[fx_type] [varchar](100) NULL,
	[fx_currency] [varchar](10) NULL,
	[fc_amount] [varchar](100) NULL,
	[rate] [varchar](100) NULL,
	[charges] [varchar](100) NULL,
	[lc_amount] [varchar](100) NULL,
	[str_seq] [varchar](255) NULL,
	[created_date] [date] NULL,
	[cust_num] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[incremental_refresh_audit_screen_poc]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incremental_refresh_audit_screen_poc](
	[id] [int] NOT NULL,
	[file_generated_date] [datetime2](7) NULL,
	[file_name] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[load_complete_dttm] [datetime2](7) NULL,
	[loaded_cnt] [varchar](255) NULL,
	[process_dttm] [datetime2](7) NULL,
	[status] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[incremental_refresh_audit_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[incremental_refresh_audit_test](
	[id] [int] NOT NULL,
	[file_generated_date] [varchar](255) NULL,
	[file_name] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[load_complete_dttm] [varchar](255) NULL,
	[loaded_cnt] [varchar](255) NULL,
	[process_dttm] [varchar](255) NULL,
	[status] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[keywords]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[keywords](
	[id] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[keyword_name] [varchar](255) NULL,
	[request_ref] [bigint] NULL,
	[untm_update_flg] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_additional_segments]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_additional_segments](
	[id] [int] NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[field_name_value] [nvarchar](max) NULL,
	[last_updated] [varchar](255) NULL,
	[segment_type] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_address]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_address](
	[id] [int] NOT NULL,
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[address_type_desc] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[postal_code] [varchar](255) NULL,
	[state_province_region] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_adverse_media]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_adverse_media](
	[id] [int] NOT NULL,
	[adverse_media_desc] [varchar](255) NULL,
	[entity_adverse_media_subcategories] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_country_association]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_country_association](
	[id] [int] NOT NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[association_type_desc] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_details_master_archive]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_details_master_archive](
	[id] [int] NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[entityguid] [varchar](255) NULL,
	[field_name_value] [nvarchar](max) NULL,
	[last_updated] [varchar](255) NULL,
	[segment_type] [varchar](255) NULL,
	[adverse_media_desc] [varchar](255) NULL,
	[entity_adverse_media_subcategories] [varchar](255) NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[enforcement_desc] [varchar](255) NULL,
	[entity_enforcement_subcategories] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[source_name_abbrev] [varchar](255) NULL,
	[expiration_date] [varchar](255) NULL,
	[identification_issuer] [varchar](255) NULL,
	[identification_number] [varchar](255) NULL,
	[identification_type_desc] [varchar](255) NULL,
	[issue_date] [varchar](255) NULL,
	[administrative_unit] [varchar](500) NULL,
	[effective_date] [varchar](255) NULL,
	[effective_date_type_desc] [varchar](255) NULL,
	[entity_pep_subcategories] [varchar](255) NULL,
	[expiration_date_type_desc] [varchar](255) NULL,
	[governing_institution] [varchar](255) NULL,
	[governing_role] [varchar](255) NULL,
	[is_active_pep] [varchar](255) NULL,
	[is_in_country_pep_only] [varchar](255) NULL,
	[is_primary_pep] [varchar](255) NULL,
	[iso_administrative_unit_level0] [varchar](255) NULL,
	[pep_admin_level_desc] [varchar](255) NULL,
	[position] [varchar](255) NULL,
	[group_desc] [varchar](255) NULL,
	[ownership_percentage] [varchar](255) NULL,
	[related_entity_guid] [varchar](255) NULL,
	[relationship_desc] [varchar](255) NULL,
	[consolidated_sanction] [varchar](255) NULL,
	[sub_category_label] [varchar](255) NULL,
	[entity_soe_domains] [varchar](255) NULL,
	[entity_soe_subcategories] [varchar](255) NULL,
	[is_active] [varchar](255) NULL,
	[source_uri] [nvarchar](max) NULL,
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[address_type_desc] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[postal_code] [varchar](255) NULL,
	[state_province_region] [varchar](255) NULL,
	[association_type_desc] [varchar](255) NULL,
	[table_type] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_details_master_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_details_master_temp](
	[id] [int] NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[entityguid] [varchar](255) NULL,
	[field_name_value] [nvarchar](max) NULL,
	[last_updated] [varchar](255) NULL,
	[segment_type] [varchar](255) NULL,
	[adverse_media_desc] [varchar](255) NULL,
	[entity_adverse_media_subcategories] [varchar](255) NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[enforcement_desc] [varchar](255) NULL,
	[entity_enforcement_subcategories] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[source_name_abbrev] [varchar](255) NULL,
	[expiration_date] [varchar](255) NULL,
	[identification_issuer] [varchar](255) NULL,
	[identification_number] [varchar](255) NULL,
	[identification_type_desc] [varchar](255) NULL,
	[issue_date] [varchar](255) NULL,
	[administrative_unit] [varchar](500) NULL,
	[effective_date] [varchar](255) NULL,
	[effective_date_type_desc] [varchar](255) NULL,
	[entity_pep_subcategories] [varchar](255) NULL,
	[expiration_date_type_desc] [varchar](255) NULL,
	[governing_institution] [varchar](255) NULL,
	[governing_role] [varchar](255) NULL,
	[is_active_pep] [varchar](255) NULL,
	[is_in_country_pep_only] [varchar](255) NULL,
	[is_primary_pep] [varchar](255) NULL,
	[iso_administrative_unit_level0] [varchar](255) NULL,
	[pep_admin_level_desc] [varchar](255) NULL,
	[position] [varchar](500) NULL,
	[group_desc] [varchar](255) NULL,
	[ownership_percentage] [varchar](255) NULL,
	[related_entity_guid] [varchar](255) NULL,
	[relationship_desc] [varchar](255) NULL,
	[consolidated_sanction] [varchar](255) NULL,
	[sub_category_label] [varchar](255) NULL,
	[entity_soe_domains] [varchar](255) NULL,
	[entity_soe_subcategories] [varchar](255) NULL,
	[is_active] [varchar](255) NULL,
	[source_uri] [nvarchar](max) NULL,
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[address_type_desc] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[country] [varchar](255) NULL,
	[postal_code] [varchar](255) NULL,
	[state_province_region] [varchar](255) NULL,
	[association_type_desc] [varchar](255) NULL,
	[table_type] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_enforcement]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_enforcement](
	[id] [int] NOT NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[enforcement_desc] [varchar](255) NULL,
	[entity_enforcement_subcategories] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[source_name_abbrev] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_entity_identification]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_entity_identification](
	[id] [int] NOT NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[expiration_date] [varchar](255) NULL,
	[identification_issuer] [varchar](255) NULL,
	[identification_number] [varchar](255) NULL,
	[identification_type_desc] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[issue_date] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_list_data_wcht_del_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_list_data_wcht_del_temp](
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_list_data_wcht_incr_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_list_data_wcht_incr_temp](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](max) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[entity_ref] [varchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_pep]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_pep](
	[id] [int] NOT NULL,
	[administrative_unit] [varchar](500) NULL,
	[effective_date] [varchar](255) NULL,
	[effective_date_type_desc] [varchar](255) NULL,
	[entity_pep_subcategories] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[expiration_date] [varchar](255) NULL,
	[expiration_date_type_desc] [varchar](255) NULL,
	[governing_institution] [varchar](255) NULL,
	[governing_role] [varchar](255) NULL,
	[is_active_pep] [varchar](255) NULL,
	[is_in_country_pep_only] [varchar](255) NULL,
	[is_primary_pep] [varchar](255) NULL,
	[iso_administrative_unit_level0] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[pep_admin_level_desc] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_position]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_position](
	[id] [int] NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[position] [varchar](500) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_relationship]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_relationship](
	[id] [int] NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[group_desc] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[ownership_percentage] [varchar](255) NULL,
	[related_entity_guid] [varchar](255) NULL,
	[relationship_desc] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_sanctions]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_sanctions](
	[id] [int] NOT NULL,
	[administrative_unit_name] [varchar](255) NULL,
	[consolidated_sanction] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[iso_standard] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[source_name_abbrev] [varchar](255) NULL,
	[sub_category_label] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_soe]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_soe](
	[id] [int] NOT NULL,
	[entity_soe_domains] [varchar](255) NULL,
	[entity_soe_subcategories] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[is_active] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lexis_nexis_source_item]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lexis_nexis_source_item](
	[id] [int] NOT NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[last_updated] [varchar](255) NULL,
	[source_uri] [nvarchar](max) NULL,
	[created_date] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_date] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data](
	[list_data_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[birth_place] [varchar](255) NULL,
	[case_id] [varchar](255) NULL,
	[cntry_of_citizenship_1_cd] [varchar](255) NULL,
	[cntry_of_citizenship_1_name] [varchar](255) NULL,
	[cntry_of_citizenship_2_cd] [varchar](255) NULL,
	[cntry_of_citizenship_2_name] [varchar](255) NULL,
	[cntry_of_residency_cd] [varchar](255) NULL,
	[cntry_of_residency_name] [varchar](255) NULL,
	[contact_num_1] [varchar](255) NULL,
	[contact_num_2] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[deceased_flag] [varchar](255) NULL,
	[dob] [date] NULL,
	[employment_typ_cat] [varchar](255) NULL,
	[employment_typ_sub_cat] [varchar](255) NULL,
	[entity_cat] [varchar](255) NULL,
	[entity_list_num] [varchar](255) NULL,
	[entity_sub_cat] [varchar](255) NULL,
	[exclude_screening_flag] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[id_num_1] [varchar](255) NULL,
	[id_num_2] [varchar](255) NULL,
	[id_typ_1] [varchar](255) NULL,
	[id_typ_2] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[list_cat] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[mailing_addr_city] [varchar](255) NULL,
	[mailing_addr_cntry_cd] [varchar](255) NULL,
	[mailing_addr_cntry_name] [varchar](255) NULL,
	[mailing_addr_line_1] [varchar](255) NULL,
	[mailing_addr_line_2] [varchar](255) NULL,
	[mailing_addr_line_3] [varchar](255) NULL,
	[mailing_addr_postal_cd] [varchar](255) NULL,
	[mailing_addr_state] [varchar](255) NULL,
	[national_id] [varchar](255) NULL,
	[parent_org_cntry_cd] [varchar](255) NULL,
	[parent_org_cntry_name] [varchar](255) NULL,
	[residential_addr_city] [varchar](255) NULL,
	[residential_addr_cntry_cd] [varchar](255) NULL,
	[residential_addr_cntry_name] [varchar](255) NULL,
	[residential_addr_line_1] [varchar](255) NULL,
	[residential_addr_line_2] [varchar](255) NULL,
	[residential_addr_line_3] [varchar](255) NULL,
	[residential_addr_postal_cd] [varchar](255) NULL,
	[residential_addr_state] [varchar](255) NULL,
	[screening_cat] [varchar](255) NULL,
	[screening_sub_cat] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[title] [varchar](255) NULL,
	[transaction_no] [varchar](255) NULL,
	[list_master_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[list_data_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_2prtb0vwvasasuqygrfiv5e65] UNIQUE NONCLUSTERED 
(
	[entity_list_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_audit]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_audit](
	[id] [bigint] NOT NULL,
	[comments] [varchar](255) NULL,
	[created_by] [varchar](255) NULL,
	[created_dttm] [datetime2](7) NULL,
	[list_data_sno] [bigint] NULL,
	[value] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_request_bkp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_request_bkp](
	[list_request_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[postal_code] [varchar](255) NULL,
	[account_number] [varchar](255) NULL,
	[address] [varchar](255) NULL,
	[bic_code] [varchar](255) NULL,
	[case_id] [varchar](255) NULL,
	[category_desc] [varchar](255) NULL,
	[change_begin_date] [date] NULL,
	[change_current_ind] [varchar](255) NULL,
	[change_end_date] [date] NULL,
	[circular_date] [date] NULL,
	[cntry_of_citizenship_2_name] [varchar](255) NULL,
	[citizenship_country_code] [varchar](255) NULL,
	[citizenship_country_name] [varchar](255) NULL,
	[city_name] [varchar](255) NULL,
	[contact_num_1] [varchar](255) NULL,
	[contact_num_2] [varchar](255) NULL,
	[country_code] [varchar](255) NULL,
	[country_name] [varchar](255) NULL,
	[cntry_of_citizenship_2_cd] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[deceased_ind] [varchar](255) NULL,
	[dob] [date] NULL,
	[employment_typ_sub_cat] [varchar](255) NULL,
	[entity_cat] [varchar](255) NULL,
	[entity_name] [varchar](255) NULL,
	[entity_sub_cat] [varchar](255) NULL,
	[entity_title] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[exclude_ind] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_address] [varchar](255) NULL,
	[identification_id] [varchar](255) NULL,
	[identification_id_2] [varchar](255) NULL,
	[identification_type_desc] [varchar](255) NULL,
	[identification_type_desc_2] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[list_cat] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[mailing_addr_city] [varchar](255) NULL,
	[mailing_addr_cntry_cd] [varchar](255) NULL,
	[mailing_addr_cntry_name] [varchar](255) NULL,
	[mailing_addr_line_1] [varchar](255) NULL,
	[mailing_addr_line_2] [varchar](255) NULL,
	[mailing_addr_line_3] [varchar](255) NULL,
	[mailing_addr_postal_cd] [varchar](255) NULL,
	[mailing_addr_state] [varchar](255) NULL,
	[middle_name] [varchar](255) NULL,
	[national_id] [varchar](255) NULL,
	[nationality_country_code] [varchar](255) NULL,
	[nationality_country_name] [varchar](255) NULL,
	[occupation_desc] [varchar](255) NULL,
	[org_country_of_business_code] [varchar](255) NULL,
	[org_country_of_business_name] [varchar](255) NULL,
	[place_of_birth] [varchar](255) NULL,
	[politically_exposed_person_ind] [varchar](255) NULL,
	[programs] [varchar](255) NULL,
	[residential_addr_line_2] [varchar](255) NULL,
	[residential_addr_line_3] [varchar](255) NULL,
	[sama_circular_number] [varchar](255) NULL,
	[sanction_type] [varchar](255) NULL,
	[screening_sub_cat] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[state_name] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[tax_id] [varchar](255) NULL,
	[tax_id_type_code] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[title] [varchar](255) NULL,
	[transaction_no] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[umbrella_keyword] [varchar](255) NULL,
	[watch_list_name] [varchar](255) NULL,
	[year_of_birth] [int] NULL,
	[request_id] [bigint] NULL,
	[remarks_1] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[list_request_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_version]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_version](
	[list_data_ver_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[birth_place] [varchar](255) NULL,
	[case_id] [varchar](255) NULL,
	[cntry_of_citizenship_1_cd] [varchar](255) NULL,
	[cntry_of_citizenship_1_name] [varchar](255) NULL,
	[cntry_of_citizenship_2_cd] [varchar](255) NULL,
	[cntry_of_citizenship_2_name] [varchar](255) NULL,
	[cntry_of_residency_cd] [varchar](255) NULL,
	[cntry_of_residency_name] [varchar](255) NULL,
	[contact_num_1] [varchar](255) NULL,
	[contact_num_2] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[deceased_flag] [varchar](255) NULL,
	[dob] [date] NULL,
	[employment_typ_cat] [varchar](255) NULL,
	[employment_typ_sub_cat] [varchar](255) NULL,
	[entity_cat] [varchar](255) NULL,
	[entity_list_num] [varchar](255) NULL,
	[entity_sub_cat] [varchar](255) NULL,
	[exclude_screening_flag] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[id_num_1] [varchar](255) NULL,
	[id_num_2] [varchar](255) NULL,
	[id_typ_1] [varchar](255) NULL,
	[id_typ_2] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[list_cat] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[mailing_addr_city] [varchar](255) NULL,
	[mailing_addr_cntry_cd] [varchar](255) NULL,
	[mailing_addr_cntry_name] [varchar](255) NULL,
	[mailing_addr_line_1] [varchar](255) NULL,
	[mailing_addr_line_2] [varchar](255) NULL,
	[mailing_addr_line_3] [varchar](255) NULL,
	[mailing_addr_postal_cd] [varchar](255) NULL,
	[mailing_addr_state] [varchar](255) NULL,
	[parent_org_cntry_cd] [varchar](255) NULL,
	[parent_org_cntry_name] [varchar](255) NULL,
	[residential_addr_city] [varchar](255) NULL,
	[residential_addr_cntry_cd] [varchar](255) NULL,
	[residential_addr_cntry_name] [varchar](255) NULL,
	[residential_addr_line_1] [varchar](255) NULL,
	[residential_addr_line_2] [varchar](255) NULL,
	[residential_addr_line_3] [varchar](255) NULL,
	[residential_addr_postal_cd] [varchar](255) NULL,
	[residential_addr_state] [varchar](255) NULL,
	[screening_cat] [varchar](255) NULL,
	[screening_sub_cat] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[title] [varchar](255) NULL,
	[transaction_no] [varchar](255) NULL,
	[list_data_sno] [int] NULL,
	[list_master_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[list_data_ver_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_version_wcht]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_version_wcht](
	[list_request_sno] [int] NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL,
	[id] [bigint] NOT NULL,
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NULL,
 CONSTRAINT [PK__list_dat__3213E84FB212B105] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_version_wcht_bkp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_version_wcht_bkp](
	[id] [bigint] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime] NULL,
	[postal_code] [varchar](255) NULL,
	[account_number] [varchar](255) NULL,
	[address] [varchar](255) NULL,
	[bic_code] [varchar](255) NULL,
	[case_id] [varchar](255) NULL,
	[category_desc] [varchar](255) NULL,
	[change_begin_date] [date] NULL,
	[change_current_ind] [varchar](255) NULL,
	[change_end_date] [date] NULL,
	[circular_date] [date] NULL,
	[cntry_of_citizenship_2_name] [varchar](255) NULL,
	[citizenship_country_code] [varchar](255) NULL,
	[citizenship_country_name] [varchar](255) NULL,
	[city_name] [varchar](255) NULL,
	[contact_num_1] [varchar](255) NULL,
	[contact_num_2] [varchar](255) NULL,
	[country_code] [varchar](255) NULL,
	[country_name] [varchar](255) NULL,
	[cntry_of_citizenship_2_cd] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[deceased_ind] [varchar](255) NULL,
	[dob] [date] NULL,
	[employment_typ_sub_cat] [varchar](255) NULL,
	[entity_cat] [varchar](255) NULL,
	[entity_name] [varchar](255) NULL,
	[entity_sub_cat] [varchar](255) NULL,
	[entity_title] [varchar](255) NULL,
	[entity_watch_list_number] [varchar](255) NULL,
	[exclude_ind] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_address] [varchar](255) NULL,
	[identification_id] [varchar](255) NULL,
	[identification_id_2] [varchar](255) NULL,
	[identification_type_desc] [varchar](255) NULL,
	[identification_type_desc_2] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[list_cat] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[mailing_addr_city] [varchar](255) NULL,
	[mailing_addr_cntry_cd] [varchar](255) NULL,
	[mailing_addr_cntry_name] [varchar](255) NULL,
	[mailing_addr_line_1] [varchar](255) NULL,
	[mailing_addr_line_2] [varchar](255) NULL,
	[mailing_addr_line_3] [varchar](255) NULL,
	[mailing_addr_postal_cd] [varchar](255) NULL,
	[mailing_addr_state] [varchar](255) NULL,
	[middle_name] [varchar](255) NULL,
	[national_id] [varchar](255) NULL,
	[nationality_country_code] [varchar](255) NULL,
	[nationality_country_name] [varchar](255) NULL,
	[occupation_desc] [varchar](255) NULL,
	[org_country_of_business_code] [varchar](255) NULL,
	[org_country_of_business_name] [varchar](255) NULL,
	[place_of_birth] [varchar](255) NULL,
	[politically_exposed_person_ind] [varchar](255) NULL,
	[programs] [varchar](255) NULL,
	[residential_addr_line_2] [varchar](255) NULL,
	[residential_addr_line_3] [varchar](255) NULL,
	[sama_circular_number] [varchar](255) NULL,
	[sanction_type] [varchar](255) NULL,
	[screening_sub_cat] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[state_name] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[tax_id] [varchar](255) NULL,
	[tax_id_type_code] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[title] [varchar](255) NULL,
	[transaction_no] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[umbrella_keyword] [varchar](255) NULL,
	[watch_list_name] [varchar](255) NULL,
	[year_of_birth] [int] NULL,
	[entity_watch_list_key] [bigint] NULL,
	[list_master_sno] [int] NULL,
	[remarks_1] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL,
	[expiry_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_100k]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_100k](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_10k]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_10k](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_250k]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_250k](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_50k]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_50k](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_archive]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_archive](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[entity_ref] [varchar](250) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_archive_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_archive_temp](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](1000) NULL,
	[IDENTIFICATION_ID_2] [varchar](255) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](1000) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](20) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](255) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](255) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[entity_ref] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_archive_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_archive_test](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[entity_ref] [varchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_delete_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_delete_test](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_duplicate_entity]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_duplicate_entity](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_failed_records]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_failed_records](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](max) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](max) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](max) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_im]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_im]
(
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CONTACT_NUM_1] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CUSTOMER_ID] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DECEASED_IND] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ENTITY_CAT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ENTITY_SUB_CAT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EXCLUDE_IND] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIRST_NAME] [nvarchar](350) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FOURTH_NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ENTITY_NAME] [nvarchar](800) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IDENTIFICATION_ID] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IDENTIFICATION_ID_2] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LAST_NAME] [varchar](350) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LIST_CAT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WATCH_LIST_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LIST_SOURCE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LIST_SUB_CAT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_CITY] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILING_ADDR_STATE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NATIONAL_ID] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CITY_NAME] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[COUNTRY_CODE] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[COUNTRY_NAME] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ADDRESS] [nvarchar](2200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[POSTAL_CODE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATE_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CATEGORY_DESC] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SECOND_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[THIRD_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ENTITY_TITLE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TAX_ID] [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TAX_ID_TYPE_CODE] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FULL_ADDRESS] [varchar](1200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SANCTION_TYPE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UMBRELLA_KEYWORD] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PROGRAMS] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TONNAGE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GRT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VESS_COUNTRY] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VESS_OWNER] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[REMARKS_1] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[REMARKS_2] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IMO_Number] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LIST_CLASSIFICATION] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CONTACT_NUM_2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SCREENING_SUB_CAT] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATUS] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TRANSACTION_NO] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BIC_CODE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TITLE] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[REQUEST_REF] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UNTM_UPDATE_FLG] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MATCH_CODE_FLG] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Account_Number] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_of_birth] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,

 PRIMARY KEY NONCLUSTERED 
(
	[ENTITY_WATCH_LIST_KEY] ASC
)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_AND_DATA )
GO
/****** Object:  Table [dbo].[list_data_wcht_incr_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_incr_temp](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](4000) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](2000) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](2000) NULL,
	[CATEGORY_DESC] [varchar](max) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](4000) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](255) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](8000) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_inf]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_inf](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[NY_ENCODE] [nvarchar](800) NULL,
	[DM_ENCODE] [nvarchar](800) NULL,
	[COMPRESSED_LENGTH] [nvarchar](800) NULL,
	[WEIGHT] [nvarchar](800) NULL,
	[NEW_NAME] [nvarchar](800) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_ncd]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_ncd](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[NY_ENCODE] [nvarchar](800) NULL,
	[DM_ENCODE] [nvarchar](800) NULL,
	[COMPRESSED_LENGTH] [nvarchar](800) NULL,
	[WEIGHT] [nvarchar](800) NULL,
	[NEW_NAME] [nvarchar](800) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LIST_DATA_WCHT_SCREEN_POC]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIST_DATA_WCHT_SCREEN_POC](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](255) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](1000) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](20) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](255) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_test]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_test](
	[ENTITY_WATCH_LIST_KEY] [numeric](12, 0) NOT NULL,
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [nvarchar](800) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [nvarchar](1000) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_vyom]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_vyom](
	[CREATED_BY] [varchar](255) NULL,
	[SYS_LOAD_DT] [date] NULL,
	[UPDATED_BY] [varchar](255) NULL,
	[SYS_UPDATE_DT] [date] NULL,
	[PLACE_OF_BIRTH] [nvarchar](1000) NULL,
	[CITIZENSHIP_COUNTRY_CODE] [varchar](255) NULL,
	[CITIZENSHIP_COUNTRY_NAME] [nvarchar](1000) NULL,
	[NATIONALITY_COUNTRY_CODE] [varchar](255) NULL,
	[NATIONALITY_COUNTRY_NAME] [nvarchar](255) NULL,
	[CONTACT_NUM_1] [varchar](255) NULL,
	[CUSTOMER_ID] [varchar](255) NULL,
	[DECEASED_IND] [varchar](255) NULL,
	[DOB] [date] NULL,
	[OCCUPATION_DESC] [varchar](500) NULL,
	[EMPLOYMENT_TYP_SUB_CAT] [varchar](255) NULL,
	[ENTITY_CAT] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_NUMBER] [varchar](255) NULL,
	[ENTITY_SUB_CAT] [varchar](255) NULL,
	[EXCLUDE_IND] [varchar](255) NULL,
	[FIRST_NAME] [nvarchar](350) NULL,
	[FOURTH_NAME] [nvarchar](255) NULL,
	[ENTITY_NAME] [varchar](255) NULL,
	[IDENTIFICATION_ID] [varchar](max) NULL,
	[IDENTIFICATION_ID_2] [varchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC] [nvarchar](max) NULL,
	[IDENTIFICATION_TYPE_DESC_2] [varchar](255) NULL,
	[LAST_NAME] [varchar](350) NULL,
	[LIST_CAT] [varchar](255) NULL,
	[WATCH_LIST_NAME] [varchar](255) NOT NULL,
	[LIST_SOURCE] [varchar](255) NOT NULL,
	[LIST_SUB_CAT] [varchar](255) NULL,
	[MAILING_ADDR_CITY] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_CD] [varchar](255) NULL,
	[MAILING_ADDR_CNTRY_NAME] [varchar](255) NULL,
	[MAILING_ADDR_LINE_1] [varchar](255) NULL,
	[MAILING_ADDR_LINE_2] [varchar](255) NULL,
	[MAILING_ADDR_LINE_3] [varchar](255) NULL,
	[MAILING_ADDR_POSTAL_CD] [varchar](255) NULL,
	[MAILING_ADDR_STATE] [varchar](255) NULL,
	[NATIONAL_ID] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_CODE] [varchar](255) NULL,
	[ORG_COUNTRY_OF_BUSINESS_NAME] [varchar](255) NULL,
	[CITY_NAME] [nvarchar](2000) NULL,
	[COUNTRY_CODE] [nvarchar](1000) NULL,
	[COUNTRY_NAME] [nvarchar](1000) NULL,
	[ADDRESS] [nvarchar](2200) NULL,
	[RESIDENTIAL_ADDR_LINE_2] [varchar](255) NULL,
	[RESIDENTIAL_ADDR_LINE_3] [varchar](255) NULL,
	[POSTAL_CODE] [varchar](255) NULL,
	[STATE_NAME] [varchar](255) NULL,
	[CATEGORY_DESC] [varchar](255) NULL,
	[SECOND_NAME] [varchar](255) NULL,
	[THIRD_NAME] [varchar](255) NULL,
	[ENTITY_TITLE] [varchar](255) NULL,
	[LIST_MASTER_SNO] [numeric](10, 0) NULL,
	[TYPE_DESC] [varchar](255) NULL,
	[TAX_ID] [nvarchar](35) NULL,
	[TAX_ID_TYPE_CODE] [char](1) NULL,
	[YEAR_OF_BIRTH] [numeric](4, 0) NULL,
	[MIDDLE_NAME] [nvarchar](255) NULL,
	[FULL_ADDRESS] [varchar](1200) NULL,
	[POLITICALLY_EXPOSED_PERSON_IND] [char](1) NULL,
	[SANCTION_TYPE] [varchar](255) NULL,
	[CIRCULAR_DATE] [datetime2](7) NULL,
	[CHANGE_BEGIN_DATE] [datetime2](7) NULL,
	[CHANGE_END_DATE] [datetime2](7) NULL,
	[CHANGE_CURRENT_IND] [char](1) NULL,
	[UMBRELLA_KEYWORD] [varchar](max) NULL,
	[PROGRAMS] [varchar](max) NULL,
	[CREATED_DT] [datetime2](7) NULL,
	[UPDATED_DT] [datetime2](7) NULL,
	[VESS_TYPE] [varchar](255) NULL,
	[TONNAGE] [varchar](255) NULL,
	[GRT] [varchar](255) NULL,
	[VESS_COUNTRY] [varchar](255) NULL,
	[VESS_OWNER] [varchar](255) NULL,
	[REMARKS_1] [nvarchar](max) NULL,
	[REMARKS_2] [varchar](max) NULL,
	[IMO_Number] [varchar](20) NULL,
	[LIST_CLASSIFICATION] [varchar](20) NULL,
	[CREATED_DTTM] [datetime] NULL,
	[UPDATED_DTTM] [datetime] NULL,
	[CASE_ID] [varchar](255) NULL,
	[CONTACT_NUM_2] [varchar](255) NULL,
	[SCREENING_SUB_CAT] [varchar](255) NULL,
	[STATUS] [varchar](max) NULL,
	[TRANSACTION_NO] [varchar](255) NULL,
	[BIC_CODE] [varchar](255) NULL,
	[SAMA_CIRCULAR_NUMBER] [varchar](255) NULL,
	[TITLE] [varchar](255) NULL,
	[REQUEST_REF] [varchar](255) NULL,
	[UNTM_UPDATE_FLG] [varchar](255) NULL,
	[MATCH_CODE_FLG] [varchar](255) NULL,
	[Account_Number] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_CD] [varchar](255) NULL,
	[CNTRY_OF_CITIZENSHIP_2_NAME] [varchar](255) NULL,
	[date_of_birth] [varchar](50) NULL,
	[IS_PEP_FLAG] [varchar](255) NULL,
	[IS_SANCTIONS_FLAG] [varchar](255) NULL,
	[IS_ADVERSE_FLAG] [varchar](255) NULL,
	[IS_SANCTION_REF_FLAG] [varchar](255) NULL,
	[entity_watch_list_num] [int] NULL,
	[remarks1] [varchar](255) NULL,
	[remarks2] [varchar](255) NULL,
	[ENTITY_WATCH_LIST_KEY] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ENTITY_WATCH_LIST_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_data_wcht_vyom_seq]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_data_wcht_vyom_seq](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[current_value] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_history]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_history](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[list_id] [int] NULL,
	[list_name] [varchar](255) NOT NULL,
	[created_by] [varchar](255) NOT NULL,
	[created_date] [datetime] NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_lookup_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_lookup_table](
	[list_id] [int] NOT NULL,
	[list_name] [varchar](255) NULL,
	[created_by] [varchar](255) NULL,
	[created_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[list_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_master]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_master](
	[list_master_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[list_name] [varchar](255) NULL,
	[list_order] [int] NULL,
	[list_sub_type] [varchar](255) NULL,
	[list_type] [varchar](255) NULL,
	[request_ref] [bigint] NULL,
	[is_active] [bit] NULL,
	[expiry_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[list_master_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[list_version]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[list_version](
	[list_ver_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[list_name] [varchar](255) NULL,
	[list_order] [int] NULL,
	[list_sub_type] [varchar](255) NULL,
	[list_type] [varchar](255) NULL,
	[list_master_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[list_ver_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lookup_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lookup_table](
	[id] [int] NOT NULL,
	[lookup_type] [varchar](255) NOT NULL,
	[lookup_values] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[matching_attrib_conf_version]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matching_attrib_conf_version](
	[mac_ver_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[action] [varchar](255) NULL,
	[match_strength] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[request_attribute_name] [varchar](255) NULL,
	[mac_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[mac_ver_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[matching_attribute_config]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matching_attribute_config](
	[mac_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[label] [varchar](255) NULL,
	[match_strength] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[request_attribute_name] [varchar](255) NULL,
	[request_ref] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[mac_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[matching_attribute_lookup]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matching_attribute_lookup](
	[mal_sno] [int] NOT NULL,
	[created_by] [varchar](200) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](200) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[field_name] [varchar](255) NULL,
	[active] [bit] NULL,
	[editable] [bit] NULL,
	[label] [varchar](255) NULL,
	[property_name] [varchar](255) NULL,
	[property_type] [varchar](255) NULL,
	[required] [bit] NULL,
 CONSTRAINT [PK__matching__52D3828E40146F83] PRIMARY KEY CLUSTERED 
(
	[mal_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[matching_attribute_lookup_bkp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matching_attribute_lookup_bkp](
	[mal_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[field_name] [varchar](255) NULL,
	[active] [bit] NULL,
	[editable] [bit] NULL,
	[label] [varchar](255) NULL,
	[property_name] [varchar](255) NULL,
	[property_type] [varchar](255) NULL,
	[required] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[mal_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[matching_outcome]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matching_outcome](
	[mo_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[investigation_process_flg] [int] NULL,
	[list_name] [varchar](255) NULL,
	[match_strength] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[matched_value] [varchar](255) NULL,
	[matching_attribute] [varchar](255) NULL,
	[matching_attribute_value] [varchar](255) NULL,
	[real_batch] [varchar](255) NULL,
	[status_code] [varchar](255) NULL,
	[status_desc] [varchar](255) NULL,
	[transaction_sno] [int] NULL,
	[entity_list_num] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[mo_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[message_list]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[message_list](
	[swift_message_id] [bigint] IDENTITY(1,1) NOT NULL,
	[swift_id] [bigint] NOT NULL,
	[created_date] [datetime] NULL,
	[created_by] [varchar](100) NULL,
	[updated_date] [datetime] NULL,
	[updated_by] [varchar](100) NULL,
	[message_type] [varchar](20) NULL,
	[is_active] [bit] NOT NULL,
	[list_type] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[swift_message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[name_screening_audit]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[name_screening_audit](
	[id] [bigint] NOT NULL,
	[dob] [date] NULL,
	[country] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[date] [date] NULL,
	[full_name] [varchar](255) NULL,
	[imo_number] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[national_id] [varchar](255) NULL,
	[search_type] [varchar](255) NULL,
	[sensitivity] [varchar](255) NULL,
	[username] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ngo_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ngo_table](
	[ngo_list] [nvarchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OUT_1]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OUT_1](
	[ID] [int] NULL,
	[LIST_NAME] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OUT_2]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OUT_2](
	[WATCH_LIST_KEY] [int] NULL,
	[LIST_SOURCE] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OUT_3]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OUT_3](
	[ID] [varchar](1) NULL,
	[LIST_NAME] [varchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parsed_entity_name_list]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parsed_entity_name_list](
	[entity_name] [nvarchar](800) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parsed_list]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parsed_list](
	[entity_watch_list_number] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[entity_watch_list_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile_id_seq]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile_id_seq](
	[sequence_name] [varchar](255) NOT NULL,
	[next_val] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[sequence_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profile_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profile_table](
	[profile_id] [bigint] NOT NULL,
	[cust_number] [varchar](255) NULL,
	[date] [date] NULL,
	[fcy_total] [float] NULL,
	[fcy_freq] [int] NULL,
	[in_freq] [int] NULL,
	[in_fwd_amt] [float] NULL,
	[in_total] [float] NULL,
	[multiple_branch_30days] [varchar](255) NULL,
	[out_acc_amt] [float] NULL,
	[out_acc_freq] [int] NULL,
	[out_acc_number] [varchar](255) NULL,
	[out_bene] [varchar](255) NULL,
	[out_forw_amt] [float] NULL,
	[out_freq] [int] NULL,
	[out_total] [float] NULL,
	[tot_in_amt_jan1] [float] NULL,
	[tot_out_amt_jan1] [float] NULL,
	[tot_txn_amt] [varchar](255) NULL,
	[wps_total] [float] NULL,
	[spm_flag_no_out] [float] NULL,
	[spm_flag_no_freq] [int] NULL,
	[spm_flag_service_type_out] [float] NULL,
	[spm_flag_service_type_freq] [int] NULL,
	[spm_flag_no_out_2] [float] NULL,
	[spm_flag_no_freq_2] [int] NULL,
	[fcy_total_2] [float] NULL,
	[fcy_freq_2] [int] NULL,
	[in_freq_2] [int] NULL,
	[non_resident_out_total] [float] NULL,
	[non_resident_out_freq] [int] NULL,
	[beneficiary_list] [varchar](max) NULL,
	[sender_list] [varchar](max) NULL,
	[tot_txn_freq] [int] NULL,
	[total_amount] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[risk_category_config]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[risk_category_config](
	[mac_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[match_type] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[sensitivity] [varchar](255) NULL,
	[entity_type] [varchar](255) NULL,
	[request_ref] [bigint] NULL,
 CONSTRAINT [PK_risk_category_config] PRIMARY KEY CLUSTERED 
(
	[mac_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rule_master]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rule_master](
	[rule_id] [int] NULL,
	[rule_name] [nvarchar](255) NULL,
	[transaction_type] [nvarchar](255) NULL,
	[field_names] [nvarchar](255) NULL,
	[Threshold_1] [float] NULL,
	[Threshold_2] [float] NULL,
	[customer_risk] [nvarchar](255) NULL,
	[look_up_method] [nvarchar](255) NULL,
	[query_map] [nvarchar](max) NULL,
	[Check_criteria] [nvarchar](255) NULL,
	[if_criteria] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL,
	[or_and] [varchar](255) NULL,
	[is_valid] [varchar](250) NULL,
	[lookback_period] [varchar](250) NULL,
	[lookback_period_parameter] [varchar](250) NULL,
	[is_triggering] [varchar](250) NULL,
	[rule_short_code] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rule_master_bkp_2023/10/25]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rule_master_bkp_2023/10/25](
	[rule_id] [int] NULL,
	[rule_name] [nvarchar](255) NULL,
	[transaction_type] [nvarchar](255) NULL,
	[field_names] [nvarchar](255) NULL,
	[Threshold_1] [float] NULL,
	[look_up_method] [nvarchar](255) NULL,
	[query_map] [nvarchar](max) NULL,
	[Check_criteria] [nvarchar](255) NULL,
	[if_criteria] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL,
	[or_and] [varchar](255) NULL,
	[is_valid] [varchar](250) NULL,
	[lookback_period] [varchar](250) NULL,
	[lookback_period_parameter] [varchar](250) NULL,
	[is_triggering] [varchar](250) NULL,
	[rule_short_code] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rule_master_bkp_30_11_2023]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rule_master_bkp_30_11_2023](
	[rule_id] [int] NULL,
	[rule_name] [nvarchar](255) NULL,
	[transaction_type] [nvarchar](255) NULL,
	[field_names] [nvarchar](255) NULL,
	[Threshold_1] [float] NULL,
	[Threshold_2] [float] NULL,
	[customer_risk] [nvarchar](255) NULL,
	[look_up_method] [nvarchar](255) NULL,
	[query_map] [nvarchar](max) NULL,
	[Check_criteria] [nvarchar](255) NULL,
	[if_criteria] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL,
	[or_and] [varchar](255) NULL,
	[is_valid] [varchar](250) NULL,
	[lookback_period] [varchar](250) NULL,
	[lookback_period_parameter] [varchar](250) NULL,
	[is_triggering] [varchar](250) NULL,
	[rule_short_code] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rule_master_capital]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rule_master_capital](
	[rule_id] [int] NULL,
	[rule_name] [nvarchar](255) NULL,
	[transaction_type] [nvarchar](255) NULL,
	[field_names] [nvarchar](255) NULL,
	[Threshold_1] [float] NULL,
	[Threshold_2] [float] NULL,
	[customer_risk] [nvarchar](255) NULL,
	[look_up_method] [nvarchar](255) NULL,
	[query_map] [nvarchar](max) NULL,
	[Check_criteria] [nvarchar](255) NULL,
	[if_criteria] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL,
	[or_and] [varchar](255) NULL,
	[is_valid] [varchar](250) NULL,
	[lookback_period] [varchar](250) NULL,
	[lookback_period_parameter] [varchar](250) NULL,
	[is_triggering] [varchar](250) NULL,
	[rule_short_code] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rule_master_dummy]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rule_master_dummy](
	[rule_id] [int] NULL,
	[rule_name] [nvarchar](255) NULL,
	[transaction_type] [nvarchar](255) NULL,
	[field_names] [nvarchar](255) NULL,
	[Threshold_1] [float] NULL,
	[look_up_method] [nvarchar](255) NULL,
	[query_map] [nvarchar](max) NULL,
	[Check_criteria] [nvarchar](255) NULL,
	[if_criteria] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL,
	[or_and] [varchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rule_master_temp]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rule_master_temp](
	[id] [int] NULL,
	[rule_name] [nvarchar](255) NULL,
	[transaction_type] [nvarchar](255) NULL,
	[field_names] [nvarchar](255) NULL,
	[Threshold_1] [float] NULL,
	[look_up_method] [nvarchar](255) NULL,
	[query_map] [nvarchar](max) NULL,
	[Check_criteria] [nvarchar](255) NULL,
	[if_criteria] [nvarchar](max) NULL,
	[Status] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RULE_VIOLATION_MASTER]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RULE_VIOLATION_MASTER](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RULE_ID] [int] NULL,
	[CUSTOMER_CODE] [varchar](255) NULL,
	[LAST_VIOLATION_DATE] [datetime2](7) NULL,
 CONSTRAINT [PK__DYNAMIC___C5241BC2B4E923423] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_customer]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_customer](
	[san_cust_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[case_id] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[country_of_citizenship_1] [varchar](255) NULL,
	[country_of_citizenship_2] [varchar](255) NULL,
	[country_of_nationality] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[entity_cat] [varchar](255) NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[investigation_process_flg] [int] NULL,
	[investigation_status] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[mail_address_city] [varchar](255) NULL,
	[mail_address_country] [varchar](255) NULL,
	[mail_address_state] [varchar](255) NULL,
	[mail_address_street_line_1] [varchar](255) NULL,
	[mail_address_street_line_2] [varchar](255) NULL,
	[mail_address_street_line_3] [varchar](255) NULL,
	[mail_address_zip_code] [varchar](255) NULL,
	[phone_number_1] [varchar](255) NULL,
	[phone_number_2] [varchar](255) NULL,
	[primary_email] [varchar](255) NULL,
	[request_mode] [varchar](255) NULL,
	[res_address_city] [varchar](255) NULL,
	[res_address_country] [varchar](255) NULL,
	[res_address_state] [varchar](255) NULL,
	[res_address_street_line_1] [varchar](255) NULL,
	[res_address_street_line_2] [varchar](255) NULL,
	[res_address_street_line_3] [varchar](255) NULL,
	[res_address_zip_code] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[secondary_email] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[transaction_amount] [float] NULL,
	[transaction_no] [varchar](255) NULL,
	[transaction_type] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[san_cust_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_99ijws4pwujnfxgtbgt3no3kw] UNIQUE NONCLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_customer_request]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_customer_request](
	[screq_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[case_id] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[country_of_citizenship_1] [varchar](255) NULL,
	[country_of_citizenship_2] [varchar](255) NULL,
	[country_of_nationality] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[mail_address_city] [varchar](255) NULL,
	[mail_address_country] [varchar](255) NULL,
	[mail_address_state] [varchar](255) NULL,
	[mail_address_street_line_1] [varchar](255) NULL,
	[mail_address_street_line_2] [varchar](255) NULL,
	[mail_address_street_line_3] [varchar](255) NULL,
	[mail_address_zip_code] [varchar](255) NULL,
	[match_strength] [varchar](255) NULL,
	[phone_number_1] [varchar](255) NULL,
	[phone_number_2] [varchar](255) NULL,
	[primary_email] [varchar](255) NULL,
	[real_batch] [varchar](255) NULL,
	[request_id] [varchar](255) NULL,
	[res_address_city] [varchar](255) NULL,
	[res_address_country] [varchar](255) NULL,
	[res_address_state] [varchar](255) NULL,
	[res_address_street_line_1] [varchar](255) NULL,
	[res_address_street_line_2] [varchar](255) NULL,
	[res_address_street_line_3] [varchar](255) NULL,
	[res_address_zip_code] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[secondary_email] [varchar](255) NULL,
	[source_id] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[transaction_amount] [varchar](255) NULL,
	[transaction_type] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[screq_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_customer_response]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_customer_response](
	[sno] [int] NOT NULL,
	[case_id] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[list_name] [varchar](255) NULL,
	[response_code] [varchar](255) NULL,
	[response_desc] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[transaction_no] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_customer_version]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_customer_version](
	[san_cust_ver_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[case_id] [varchar](255) NULL,
	[country_of_birth] [varchar](255) NULL,
	[country_of_citizenship_1] [varchar](255) NULL,
	[country_of_citizenship_2] [varchar](255) NULL,
	[country_of_nationality] [varchar](255) NULL,
	[customer_id] [varchar](255) NULL,
	[date_of_birth] [date] NULL,
	[first_name] [varchar](255) NULL,
	[fourth_name] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[mail_address_city] [varchar](255) NULL,
	[mail_address_country] [varchar](255) NULL,
	[mail_address_state] [varchar](255) NULL,
	[mail_address_street_line_1] [varchar](255) NULL,
	[mail_address_street_line_2] [varchar](255) NULL,
	[mail_address_street_line_3] [varchar](255) NULL,
	[mail_address_zip_code] [varchar](255) NULL,
	[phone_number_1] [varchar](255) NULL,
	[phone_number_2] [varchar](255) NULL,
	[primary_email] [varchar](255) NULL,
	[res_address_city] [varchar](255) NULL,
	[res_address_country] [varchar](255) NULL,
	[res_address_state] [varchar](255) NULL,
	[res_address_street_line_1] [varchar](255) NULL,
	[res_address_street_line_2] [varchar](255) NULL,
	[res_address_street_line_3] [varchar](255) NULL,
	[res_address_zip_code] [varchar](255) NULL,
	[second_name] [varchar](255) NULL,
	[secondary_email] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[third_name] [varchar](255) NULL,
	[transaction_amount] [numeric](19, 2) NULL,
	[transaction_type] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
	[sc_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[san_cust_ver_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_request_ns]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_request_ns](
	[screq_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[country] [varchar](255) NULL,
	[country_sensitivity] [varchar](255) NULL,
	[customer_sensitivity] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[imo] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[national_id] [varchar](255) NULL,
	[real_batch] [varchar](255) NULL,
	[request_id] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[screening_type] [varchar](255) NULL,
	[sensitivity] [varchar](255) NULL,
	[source_id] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[ui_flag] [varchar](255) NULL,
	[vessel_sensitivity] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[cust_num] [varchar](255) NULL,
	[delta_flag] [varchar](255) NULL,
	[identification_number] [varchar](50) NULL,
 CONSTRAINT [PK__sanction__57A415169CAFC218ABC] PRIMARY KEY CLUSTERED 
(
	[screq_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_request_ns_bkp_2025_06_12]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_request_ns_bkp_2025_06_12](
	[screq_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[country] [varchar](255) NULL,
	[country_sensitivity] [varchar](255) NULL,
	[customer_sensitivity] [varchar](255) NULL,
	[dob] [varchar](255) NULL,
	[full_name] [varchar](255) NULL,
	[imo] [varchar](255) NULL,
	[match_type] [varchar](255) NULL,
	[national_id] [varchar](255) NULL,
	[real_batch] [varchar](255) NULL,
	[request_id] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[screening_type] [varchar](255) NULL,
	[sensitivity] [varchar](255) NULL,
	[source_id] [varchar](255) NULL,
	[type_desc] [varchar](255) NULL,
	[ui_flag] [varchar](255) NULL,
	[vessel_sensitivity] [varchar](255) NULL,
	[list_source] [varchar](255) NULL,
	[list_sub_cat] [varchar](255) NULL,
	[cust_num] [varchar](255) NULL,
	[delta_flag] [varchar](255) NULL,
	[identification_number] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[screq_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_response_ns]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_response_ns](
	[response_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[entity_type] [varchar](255) NULL,
	[investigation_process_flg] [int] NULL,
	[matched_name] [varchar](255) NULL,
	[real_batch] [varchar](255) NULL,
	[request_ref_no] [int] NULL,
	[status_code] [varchar](255) NULL,
	[status_desc] [varchar](255) NULL,
	[whitelist_flag] [varchar](250) NULL,
 CONSTRAINT [PK__sanction__F5358E36AC57EBFABC] PRIMARY KEY CLUSTERED 
(
	[response_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_response_ns_bkp_2025_06_12]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_response_ns_bkp_2025_06_12](
	[response_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[entity_type] [varchar](255) NULL,
	[investigation_process_flg] [int] NULL,
	[matched_name] [varchar](255) NULL,
	[real_batch] [varchar](255) NULL,
	[request_ref_no] [int] NULL,
	[status_code] [varchar](255) NULL,
	[status_desc] [varchar](255) NULL,
	[whitelist_flag] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[response_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_rule_response]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_rule_response](
	[response_sno] [bigint] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[investigration_process_flag] [varchar](255) NULL,
	[matched_rule_id] [varchar](255) NULL,
	[matched_rule_name] [varchar](255) NULL,
	[request_id] [varchar](255) NULL,
	[transaction_type] [varchar](255) NULL,
	[transaction_amount] [varchar](255) NULL,
	[rules] [varchar](255) NULL,
	[request_ref_no] [varchar](255) NULL,
	[transaction_currency] [varchar](255) NULL,
	[istr_flag] [varchar](255) NULL,
	[istr_remark] [varchar](255) NULL,
	[transaction_ref_no] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[response_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_transaction_request]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_transaction_request](
	[streq_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[ben_bic] [varchar](255) NULL,
	[ben_bank_name] [varchar](255) NULL,
	[ben_country] [varchar](255) NULL,
	[ben_id] [varchar](255) NULL,
	[ben_id_num] [varchar](255) NULL,
	[ben_name] [varchar](255) NULL,
	[ben_nationality] [varchar](255) NULL,
	[country_sensitivity] [varchar](255) NULL,
	[list_to_screen] [varchar](255) NULL,
	[message_sensitivity] [varchar](255) NULL,
	[name_sensitivity] [varchar](255) NULL,
	[purpose_of_transfer] [varchar](255) NULL,
	[rem_id] [varchar](255) NULL,
	[rem_id_num] [varchar](255) NULL,
	[rem_name] [varchar](255) NULL,
	[rem_nationality] [varchar](255) NULL,
	[request_id] [varchar](255) NULL,
	[risk_category] [varchar](255) NULL,
	[source_id] [varchar](255) NULL,
	[trans_amount] [varchar](255) NULL,
	[trans_currency] [varchar](255) NULL,
	[trans_ref] [varchar](255) NULL,
	[vessel_sensitivity] [varchar](255) NULL,
	[screening_flag] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[streq_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanction_transaction_response]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanction_transaction_response](
	[response_sno] [int] NOT NULL,
	[created_by] [varchar](255) NULL,
	[created_dt] [date] NULL,
	[created_dttm] [datetime2](7) NULL,
	[updated_by] [varchar](255) NULL,
	[updated_dt] [date] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[investigation_process_flg] [int] NULL,
	[real_batch] [varchar](255) NULL,
	[request_ref_no] [int] NULL,
	[status_code] [varchar](255) NULL,
	[status_desc] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[response_sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanctions_country_error_lookup]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanctions_country_error_lookup](
	[Country_List] [nvarchar](50) NOT NULL,
	[Standardized_Country] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sanctions_country_lookup]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sanctions_country_lookup](
	[Country_List] [nvarchar](100) NOT NULL,
	[Standardized_Country] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SANCTIONS_LOOKUP]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SANCTIONS_LOOKUP](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[LOOKUP_NODE] [varchar](50) NULL,
	[LOOKUP_VALUE] [varchar](100) NULL,
	[LOOKUP_CODE] [varchar](50) NULL,
	[LOOKUP_VALUE_TYPE] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[score_card]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[score_card](
	[sno] [int] NOT NULL,
	[country_score_lower] [int] NULL,
	[country_score_upper] [int] NULL,
	[name_score_addition] [int] NULL,
	[name_score_lower] [int] NULL,
	[name_score_upper] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[score_mapping]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[score_mapping](
	[score_id] [int] NOT NULL,
	[country_score] [int] NULL,
	[name_score] [int] NULL,
	[watch_list_key] [bigint] NULL,
	[response_sno] [int] NULL,
 CONSTRAINT [PK__score_ma__8CA19050CA0C978BABC] PRIMARY KEY CLUSTERED 
(
	[score_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[score_mapping_bkp_2025_06_12]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[score_mapping_bkp_2025_06_12](
	[score_id] [int] NOT NULL,
	[country_score] [int] NULL,
	[name_score] [int] NULL,
	[watch_list_key] [bigint] NULL,
	[response_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[score_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[score_mapping_transaction]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[score_mapping_transaction](
	[score_id] [int] NOT NULL,
	[country_score] [int] NULL,
	[match_identifier] [varchar](255) NULL,
	[name_score] [int] NULL,
	[purpose_score] [int] NULL,
	[score] [int] NULL,
	[watch_list_key] [bigint] NULL,
	[response_sno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[score_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[scorecard_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[scorecard_table](
	[scorecard_id] [int] NOT NULL,
	[country_sensitivity] [varchar](255) NULL,
	[final_scorecard] [varchar](255) NULL,
	[name_sensitivity] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[scorecard_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[standardization_lookup]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[standardization_lookup](
	[id] [int] NOT NULL,
	[input_word] [varchar](255) NULL,
	[output_word] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[swift]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[swift](
	[swift_id] [bigint] IDENTITY(1,1) NOT NULL,
	[message_type] [varchar](20) NOT NULL,
	[created_date] [datetime] NULL,
	[created_by] [varchar](100) NULL,
	[updated_date] [datetime] NULL,
	[updated_by] [varchar](100) NULL,
	[remitter_name] [bit] NULL,
	[remitter_nationality] [bit] NULL,
	[remitter_date_of_birth] [bit] NULL,
	[remitter_year_of_birth] [bit] NULL,
	[remitter_identification_no] [bit] NULL,
	[beneficiary_name] [bit] NULL,
	[beneficiary_nationality] [bit] NULL,
	[beneficiary_date_of_birth] [bit] NULL,
	[beneficiary_year_of_birth] [bit] NULL,
	[beneficiary_identification_no] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[swift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestTable]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTable](
	[list_name] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction_id_seq]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction_id_seq](
	[sequence_name] [varchar](255) NOT NULL,
	[next_val] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[sequence_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction_table]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction_table](
	[transaction_id] [bigint] NOT NULL,
	[authorized_person] [varchar](255) NULL,
	[beneficiary_account_number] [varchar](255) NULL,
	[beneficiary_bank] [varchar](255) NULL,
	[beneficiary_country] [varchar](255) NULL,
	[beneficiary_dob] [varchar](255) NULL,
	[beneficiary_name] [varchar](255) NULL,
	[beneficiary_type] [varchar](255) NULL,
	[branch_desc] [varchar](255) NULL,
	[corporate_legal_form] [varchar](255) NULL,
	[corporate_trade_type] [varchar](255) NULL,
	[corporate_type] [varchar](255) NULL,
	[correspondent_org_desc] [varchar](255) NULL,
	[correspondent_type] [varchar](255) NULL,
	[customer_close_monitor_flag] [varchar](255) NULL,
	[customer_code] [varchar](255) NULL,
	[customer_risk] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[imo] [varchar](255) NULL,
	[invoice_details] [varchar](255) NULL,
	[is_pep] [varchar](255) NULL,
	[pay_modes] [varchar](255) NULL,
	[promotion_amount] [varchar](255) NULL,
	[relationship] [varchar](255) NULL,
	[remarks] [varchar](255) NULL,
	[remitter_dob] [varchar](255) NULL,
	[remitter_name] [varchar](255) NULL,
	[remitter_nationality] [varchar](255) NULL,
	[remitter_type] [varchar](255) NULL,
	[resident_type] [varchar](255) NULL,
	[sender_id_type] [varchar](255) NULL,
	[sender_to_receiver_message] [varchar](255) NULL,
	[service_type] [varchar](255) NULL,
	[source_of_fund] [varchar](255) NULL,
	[spm_flag] [varchar](255) NULL,
	[suspicious_flag] [varchar](255) NULL,
	[suspicious_remark] [varchar](255) NULL,
	[transaction_amount_fcy] [varchar](255) NULL,
	[transaction_amount_lcy] [varchar](255) NULL,
	[transaction_charge] [varchar](255) NULL,
	[transaction_currency] [varchar](255) NULL,
	[transaction_purpose_desc] [varchar](255) NULL,
	[transaction_ref_no] [varchar](255) NULL,
	[transaction_source] [varchar](255) NULL,
	[transaction_status] [varchar](255) NULL,
	[transaction_type] [varchar](255) NULL,
	[transaction_user] [varchar](255) NULL,
	[transaction_value_date] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
	[unique_id_3] [varchar](255) NULL,
	[vessel_name] [varchar](255) NULL,
	[str_seq] [varchar](255) NULL,
	[is_stakeholder_pep] [varchar](100) NULL,
	[name_of_stakeholders] [varchar](max) NULL,
	[forex_transactions] [varchar](max) NULL,
	[remitter_country] [varchar](255) NULL,
	[beneficiary_nationality] [varchar](255) NULL,
	[remitter_year_of_birth] [varchar](255) NULL,
	[remitter_identification_number] [varchar](255) NULL,
	[remitter_sensitivity] [varchar](255) NULL,
	[remitter_match_type] [varchar](255) NULL,
	[remitter_risk_category] [varchar](255) NULL,
	[remitter_type_desc] [varchar](255) NULL,
	[remitter_list_source] [varchar](255) NULL,
	[remitter_list_sub_cat] [varchar](255) NULL,
	[beneficiary_year_of_birth] [varchar](255) NULL,
	[beneficiary_identification_number] [varchar](255) NULL,
	[beneficiary_sensitivity] [varchar](255) NULL,
	[beneficiary_match_type] [varchar](255) NULL,
	[beneficiary_risk_category] [varchar](255) NULL,
	[beneficiary_type_desc] [varchar](255) NULL,
	[beneficiary_list_source] [varchar](255) NULL,
	[beneficiary_list_sub_cat] [varchar](255) NULL,
	[date_time] [datetime2](7) NULL,
	[remitter_nationality_screening] [varchar](255) NULL,
	[beneficiary_nationality_screening] [varchar](255) NULL,
	[stakeholder_match_flag] [bit] NULL,
	[bank_name_match_flag] [bit] NULL,
	[vessel_match_flag] [bit] NULL,
	[is_rule_violation] [bit] NULL,
	[annual_threshold_amount] [varchar](255) NULL,
	[annual_threshold_count] [varchar](255) NULL,
	[beneficiary_nationality_risk] [varchar](255) NULL,
	[is_employee_flag] [varchar](255) NULL,
	[is_seamen] [varchar](255) NULL,
	[is_walk_in_flag] [varchar](255) NULL,
	[istr_flag] [varchar](255) NULL,
	[remitter_account_number] [varchar](255) NULL,
	[remitter_nationality_currency] [varchar](255) NULL,
	[remitter_nationality_risk] [varchar](255) NULL,
	[str_flag] [varchar](255) NULL,
	[rule_name] [varchar](255) NULL,
	[rule_1_triggering_text] [varchar](250) NULL,
	[rule_1_triggering_value] [numeric](18, 0) NULL,
	[rule_1] [numeric](18, 0) NULL,
	[rule_2] [numeric](18, 0) NULL,
	[rule_2_triggering_text] [varchar](255) NULL,
	[rule_2_triggering_value] [numeric](18, 0) NULL,
	[rule_3] [numeric](18, 0) NULL,
	[rule_3_triggering_text] [varchar](255) NULL,
	[rule_3_triggering_value] [numeric](18, 0) NULL,
	[rule_4] [numeric](18, 0) NULL,
	[rule_4_triggering_text] [varchar](255) NULL,
	[rule_4_triggering_value] [numeric](18, 0) NULL,
	[transaction_amount_lcy_numeric] [numeric](38, 2) NULL,
	[rule_5] [numeric](18, 0) NULL,
	[rule_5_triggering_text] [varchar](255) NULL,
	[rule_5_triggering_value] [numeric](18, 2) NULL,
	[rule_6] [numeric](18, 0) NULL,
	[rule_6_triggering_text] [varchar](255) NULL,
	[rule_6_triggering_value] [numeric](18, 2) NULL,
	[rule_7] [numeric](18, 0) NULL,
	[rule_7_triggering_text] [varchar](255) NULL,
	[rule_7_triggering_value] [numeric](18, 2) NULL,
	[rule_8] [numeric](18, 0) NULL,
	[rule_8_triggering_text] [varchar](255) NULL,
	[rule_8_triggering_value] [numeric](18, 2) NULL,
	[rule_9] [numeric](18, 0) NULL,
	[rule_9_triggering_text] [varchar](255) NULL,
	[rule_9_triggering_value] [numeric](18, 0) NULL,
	[rule_10] [numeric](18, 0) NULL,
	[rule_10_triggering_text] [varchar](255) NULL,
	[rule_10_triggering_value] [numeric](18, 0) NULL,
	[rule_11] [numeric](18, 0) NULL,
	[rule_11_triggering_text] [varchar](255) NULL,
	[rule_11_triggering_value] [numeric](18, 0) NULL,
	[rule_12] [numeric](18, 0) NULL,
	[rule_12_triggering_text] [varchar](255) NULL,
	[rule_12_triggering_value] [numeric](18, 2) NULL,
	[rule_13] [numeric](18, 0) NULL,
	[rule_13_triggering_text] [varchar](255) NULL,
	[rule_13_triggering_value] [numeric](18, 2) NULL,
	[rule_14] [numeric](18, 0) NULL,
	[rule_14_triggering_text] [varchar](255) NULL,
	[rule_14_triggering_value] [numeric](18, 2) NULL,
	[rule_15] [numeric](18, 0) NULL,
	[rule_15_triggering_text] [varchar](255) NULL,
	[rule_15_triggering_value] [numeric](18, 2) NULL,
	[cross_country_nationality] [varchar](10) NULL,
	[rule_16] [numeric](18, 0) NULL,
	[rule_16_triggering_text] [varchar](255) NULL,
	[rule_16_triggering_value] [numeric](18, 2) NULL,
	[rule_17] [numeric](18, 0) NULL,
	[rule_17_triggering_text] [varchar](255) NULL,
	[rule_17_triggering_value] [numeric](18, 2) NULL,
	[rule_18] [numeric](18, 0) NULL,
	[rule_18_triggering_text] [varchar](255) NULL,
	[rule_18_triggering_value] [numeric](18, 2) NULL,
	[rule_19] [numeric](18, 0) NULL,
	[rule_19_triggering_text] [varchar](255) NULL,
	[rule_19_triggering_value] [numeric](18, 0) NULL,
	[remitter_dowjones_category] [varchar](1000) NULL,
	[beneficiary_dowjones_category] [varchar](1000) NULL,
	[bank_dowjones_category] [varchar](1000) NULL,
	[vessel_dowjones_category] [varchar](1000) NULL,
	[core_transaction_status] [varchar](100) NULL,
	[transaction_amount_buy_lcy] [float] NULL,
	[transaction_amount_sell_lcy] [float] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[rule_20] [numeric](18, 0) NULL,
	[rule_20_triggering_text] [varchar](255) NULL,
	[rule_20_triggering_value] [numeric](18, 2) NULL,
	[rule_1_violation_flag] [numeric](18, 0) NULL,
	[rule_20_violation_flag] [numeric](18, 0) NULL,
	[forex_buy_lcy] [float] NULL,
	[forex_sell_lcy] [float] NULL,
	[forex_buy_quarter_avg] [float] NULL,
	[forex_sell_quarter_avg] [float] NULL,
	[outward_rem_quarter_avg] [float] NULL,
	[tio08_inward_outward_amount] [float] NULL,
	[tio09_forex_amount] [float] NULL,
	[tio09_outward_amount] [float] NULL,
	[txn_to_home_country] [varchar](10) NULL,
	[correspondence_imts_agent] [varchar](255) NULL,
	[screened_product] [varchar](255) NULL,
	[remitter_address] [nvarchar](255) NULL,
	[remitter_bank] [nvarchar](255) NULL,
	[remitter_branch] [nvarchar](255) NULL,
	[remitter_phone_no] [nvarchar](20) NULL,
	[customer_nationality] [char](2) NULL,
	[visa_type] [nvarchar](50) NULL,
	[transaction_cd_indicator] [char](1) NULL,
	[product] [nvarchar](100) NULL,
	[beneficiary_branch] [nvarchar](255) NULL,
	[beneficiary_id_type] [nvarchar](50) NULL,
	[beneficiary_phone_no] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction_table_bkp_2023_10_27]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction_table_bkp_2023_10_27](
	[transaction_id] [bigint] NOT NULL,
	[bene_acc_first_name] [varchar](255) NULL,
	[bene_acc_last_name] [varchar](255) NULL,
	[bene_acc_num] [varchar](255) NULL,
	[beneficiary_type] [varchar](255) NULL,
	[block_reason] [varchar](255) NULL,
	[counter_party] [varchar](255) NULL,
	[cust_no] [varchar](255) NULL,
	[destination_country] [varchar](255) NULL,
	[originating_country] [varchar](255) NULL,
	[purpose_of_transfer] [varchar](255) NULL,
	[remitter_type] [varchar](255) NULL,
	[txn_amt] [float] NULL,
	[txn_amt_currency] [varchar](255) NULL,
	[txn_branch_code] [varchar](255) NULL,
	[txn_dttm] [varchar](255) NULL,
	[txn_ref_no] [varchar](255) NULL,
	[txn_status] [varchar](255) NULL,
	[txn_type] [varchar](255) NULL,
	[istr_flag] [int] NULL,
	[istr_remark] [varchar](255) NULL,
	[transaction_request_ref_no] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
	[unique_id_3] [varchar](255) NULL,
	[str_seq] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction_table_ews]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction_table_ews](
	[transaction_id] [bigint] NOT NULL,
	[authorized_person] [varchar](255) NULL,
	[beneficiary_account_number] [varchar](255) NULL,
	[beneficiary_bank] [varchar](255) NULL,
	[beneficiary_country] [varchar](255) NULL,
	[beneficiary_dob] [varchar](255) NULL,
	[beneficiary_name] [varchar](255) NULL,
	[beneficiary_type] [varchar](255) NULL,
	[branch_desc] [varchar](255) NULL,
	[corporate_legal_form] [varchar](255) NULL,
	[corporate_trade_type] [varchar](255) NULL,
	[corporate_type] [varchar](255) NULL,
	[correspondent_org_desc] [varchar](255) NULL,
	[correspondent_type] [varchar](255) NULL,
	[customer_close_monitor_flag] [varchar](255) NULL,
	[customer_code] [varchar](255) NULL,
	[customer_risk] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[imo] [varchar](255) NULL,
	[invoice_details] [varchar](255) NULL,
	[is_pep] [varchar](255) NULL,
	[pay_modes] [varchar](255) NULL,
	[promotion_amount] [varchar](255) NULL,
	[relationship] [varchar](255) NULL,
	[remarks] [varchar](255) NULL,
	[remitter_dob] [varchar](255) NULL,
	[remitter_name] [varchar](255) NULL,
	[remitter_nationality] [varchar](255) NULL,
	[remitter_type] [varchar](255) NULL,
	[resident_type] [varchar](255) NULL,
	[sender_id_type] [varchar](255) NULL,
	[sender_to_receiver_message] [varchar](255) NULL,
	[service_type] [varchar](255) NULL,
	[source_of_fund] [varchar](255) NULL,
	[spm_flag] [varchar](255) NULL,
	[suspicious_flag] [varchar](255) NULL,
	[suspicious_remark] [varchar](255) NULL,
	[transaction_amount_fcy] [varchar](255) NULL,
	[transaction_amount_lcy] [varchar](255) NULL,
	[transaction_charge] [varchar](255) NULL,
	[transaction_currency] [varchar](255) NULL,
	[transaction_purpose_desc] [varchar](255) NULL,
	[transaction_ref_no] [varchar](255) NULL,
	[transaction_source] [varchar](255) NULL,
	[transaction_status] [varchar](255) NULL,
	[transaction_type] [varchar](255) NULL,
	[transaction_user] [varchar](255) NULL,
	[transaction_value_date] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
	[unique_id_3] [varchar](255) NULL,
	[vessel_name] [varchar](255) NULL,
	[str_seq] [varchar](255) NULL,
	[is_stakeholder_pep] [varchar](100) NULL,
	[name_of_stakeholders] [varchar](max) NULL,
	[forex_transactions] [varchar](max) NULL,
	[remitter_country] [varchar](255) NULL,
	[beneficiary_nationality] [varchar](255) NULL,
	[remitter_year_of_birth] [varchar](255) NULL,
	[remitter_identification_number] [varchar](255) NULL,
	[remitter_sensitivity] [varchar](255) NULL,
	[remitter_match_type] [varchar](255) NULL,
	[remitter_risk_category] [varchar](255) NULL,
	[remitter_type_desc] [varchar](255) NULL,
	[remitter_list_source] [varchar](255) NULL,
	[remitter_list_sub_cat] [varchar](255) NULL,
	[beneficiary_year_of_birth] [varchar](255) NULL,
	[beneficiary_identification_number] [varchar](255) NULL,
	[beneficiary_sensitivity] [varchar](255) NULL,
	[beneficiary_match_type] [varchar](255) NULL,
	[beneficiary_risk_category] [varchar](255) NULL,
	[beneficiary_type_desc] [varchar](255) NULL,
	[beneficiary_list_source] [varchar](255) NULL,
	[beneficiary_list_sub_cat] [varchar](255) NULL,
	[date_time] [datetime2](7) NULL,
	[remitter_nationality_screening] [varchar](255) NULL,
	[beneficiary_nationality_screening] [varchar](255) NULL,
	[stakeholder_match_flag] [bit] NULL,
	[bank_name_match_flag] [bit] NULL,
	[vessel_match_flag] [bit] NULL,
	[is_rule_violation] [bit] NULL,
	[annual_threshold_amount] [varchar](255) NULL,
	[annual_threshold_count] [varchar](255) NULL,
	[beneficiary_nationality_risk] [varchar](255) NULL,
	[is_employee_flag] [varchar](255) NULL,
	[is_seamen] [varchar](255) NULL,
	[is_walk_in_flag] [varchar](255) NULL,
	[istr_flag] [varchar](255) NULL,
	[remitter_account_number] [varchar](255) NULL,
	[remitter_nationality_currency] [varchar](255) NULL,
	[remitter_nationality_risk] [varchar](255) NULL,
	[str_flag] [varchar](255) NULL,
	[rule_name] [varchar](255) NULL,
	[rule_1_triggering_text] [varchar](250) NULL,
	[rule_1_triggering_value] [numeric](18, 0) NULL,
	[rule_1] [numeric](18, 0) NULL,
	[rule_2] [numeric](18, 0) NULL,
	[rule_2_triggering_text] [varchar](255) NULL,
	[rule_2_triggering_value] [numeric](18, 0) NULL,
	[rule_3] [numeric](18, 0) NULL,
	[rule_3_triggering_text] [varchar](255) NULL,
	[rule_3_triggering_value] [numeric](18, 0) NULL,
	[rule_4] [numeric](18, 0) NULL,
	[rule_4_triggering_text] [varchar](255) NULL,
	[rule_4_triggering_value] [numeric](18, 0) NULL,
	[transaction_amount_lcy_numeric] [numeric](38, 2) NULL,
	[rule_5] [numeric](18, 0) NULL,
	[rule_5_triggering_text] [varchar](255) NULL,
	[rule_5_triggering_value] [numeric](18, 2) NULL,
	[rule_6] [numeric](18, 0) NULL,
	[rule_6_triggering_text] [varchar](255) NULL,
	[rule_6_triggering_value] [numeric](18, 2) NULL,
	[rule_7] [numeric](18, 0) NULL,
	[rule_7_triggering_text] [varchar](255) NULL,
	[rule_7_triggering_value] [numeric](18, 2) NULL,
	[rule_8] [numeric](18, 0) NULL,
	[rule_8_triggering_text] [varchar](255) NULL,
	[rule_8_triggering_value] [numeric](18, 2) NULL,
	[rule_9] [numeric](18, 0) NULL,
	[rule_9_triggering_text] [varchar](255) NULL,
	[rule_9_triggering_value] [numeric](18, 0) NULL,
	[rule_10] [numeric](18, 0) NULL,
	[rule_10_triggering_text] [varchar](255) NULL,
	[rule_10_triggering_value] [numeric](18, 0) NULL,
	[rule_11] [numeric](18, 0) NULL,
	[rule_11_triggering_text] [varchar](255) NULL,
	[rule_11_triggering_value] [numeric](18, 0) NULL,
	[rule_12] [numeric](18, 0) NULL,
	[rule_12_triggering_text] [varchar](255) NULL,
	[rule_12_triggering_value] [numeric](18, 2) NULL,
	[rule_13] [numeric](18, 0) NULL,
	[rule_13_triggering_text] [varchar](255) NULL,
	[rule_13_triggering_value] [numeric](18, 2) NULL,
	[rule_14] [numeric](18, 0) NULL,
	[rule_14_triggering_text] [varchar](255) NULL,
	[rule_14_triggering_value] [numeric](18, 2) NULL,
	[rule_15] [numeric](18, 0) NULL,
	[rule_15_triggering_text] [varchar](255) NULL,
	[rule_15_triggering_value] [numeric](18, 2) NULL,
	[cross_country_nationality] [varchar](10) NULL,
	[rule_16] [numeric](18, 0) NULL,
	[rule_16_triggering_text] [varchar](255) NULL,
	[rule_16_triggering_value] [numeric](18, 2) NULL,
	[rule_17] [numeric](18, 0) NULL,
	[rule_17_triggering_text] [varchar](255) NULL,
	[rule_17_triggering_value] [numeric](18, 2) NULL,
	[rule_18] [numeric](18, 0) NULL,
	[rule_18_triggering_text] [varchar](255) NULL,
	[rule_18_triggering_value] [numeric](18, 2) NULL,
	[rule_19] [numeric](18, 0) NULL,
	[rule_19_triggering_text] [varchar](255) NULL,
	[rule_19_triggering_value] [numeric](18, 0) NULL,
	[remitter_dowjones_category] [varchar](1000) NULL,
	[beneficiary_dowjones_category] [varchar](1000) NULL,
	[bank_dowjones_category] [varchar](1000) NULL,
	[vessel_dowjones_category] [varchar](1000) NULL,
	[core_transaction_status] [varchar](100) NULL,
	[transaction_amount_buy_lcy] [float] NULL,
	[transaction_amount_sell_lcy] [float] NULL,
	[updated_dttm] [datetime2](7) NULL,
	[rule_20] [numeric](18, 0) NULL,
	[rule_20_triggering_text] [varchar](255) NULL,
	[rule_20_triggering_value] [numeric](18, 2) NULL,
	[rule_1_violation_flag] [numeric](18, 0) NULL,
	[rule_20_violation_flag] [numeric](18, 0) NULL,
	[forex_buy_lcy] [float] NULL,
	[forex_sell_lcy] [float] NULL,
	[forex_buy_quarter_avg] [float] NULL,
	[forex_sell_quarter_avg] [float] NULL,
	[outward_rem_quarter_avg] [float] NULL,
	[tio08_inward_outward_amount] [float] NULL,
	[tio09_forex_amount] [float] NULL,
	[tio09_outward_amount] [float] NULL,
	[txn_to_home_country] [varchar](10) NULL,
	[correspondence_imts_agent] [varchar](255) NULL,
	[screened_product] [varchar](255) NULL,
	[remitter_address] [nvarchar](255) NULL,
	[remitter_bank] [nvarchar](255) NULL,
	[remitter_branch] [nvarchar](255) NULL,
	[remitter_phone_no] [nvarchar](20) NULL,
	[customer_nationality] [char](2) NULL,
	[visa_type] [nvarchar](50) NULL,
	[transaction_cd_indicator] [char](1) NULL,
	[product] [nvarchar](100) NULL,
	[beneficiary_branch] [nvarchar](255) NULL,
	[beneficiary_id_type] [nvarchar](50) NULL,
	[beneficiary_phone_no] [nvarchar](20) NULL,
 CONSTRAINT [PK__transact__85C600AF2BE765] PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction_table_uat_testing]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction_table_uat_testing](
	[transaction_id] [bigint] NOT NULL,
	[authorized_person] [varchar](255) NULL,
	[beneficiary_account_number] [varchar](255) NULL,
	[beneficiary_bank] [varchar](255) NULL,
	[beneficiary_country] [varchar](255) NULL,
	[beneficiary_dob] [varchar](255) NULL,
	[beneficiary_name] [varchar](255) NULL,
	[beneficiary_type] [varchar](255) NULL,
	[branch_desc] [varchar](255) NULL,
	[corporate_legal_form] [varchar](255) NULL,
	[corporate_trade_type] [varchar](255) NULL,
	[corporate_type] [varchar](255) NULL,
	[correspondent_org_desc] [varchar](255) NULL,
	[correspondent_type] [varchar](255) NULL,
	[customer_close_monitor_flag] [varchar](255) NULL,
	[customer_code] [varchar](255) NULL,
	[customer_risk] [varchar](255) NULL,
	[customer_type] [varchar](255) NULL,
	[imo] [varchar](255) NULL,
	[invoice_details] [varchar](255) NULL,
	[is_pep] [varchar](255) NULL,
	[pay_modes] [varchar](255) NULL,
	[promotion_amount] [varchar](255) NULL,
	[relationship] [varchar](255) NULL,
	[remarks] [varchar](255) NULL,
	[remitter_dob] [varchar](255) NULL,
	[remitter_name] [varchar](255) NULL,
	[remitter_nationality] [varchar](255) NULL,
	[remitter_type] [varchar](255) NULL,
	[resident_type] [varchar](255) NULL,
	[sender_id_type] [varchar](255) NULL,
	[sender_to_receiver_message] [varchar](255) NULL,
	[service_type] [varchar](255) NULL,
	[source_of_fund] [varchar](255) NULL,
	[spm_flag] [varchar](255) NULL,
	[suspicious_flag] [varchar](255) NULL,
	[suspicious_remark] [varchar](255) NULL,
	[transaction_amount_fcy] [varchar](255) NULL,
	[transaction_amount_lcy] [varchar](255) NULL,
	[transaction_charge] [varchar](255) NULL,
	[transaction_currency] [varchar](255) NULL,
	[transaction_purpose_desc] [varchar](255) NULL,
	[transaction_ref_no] [varchar](255) NULL,
	[transaction_source] [varchar](255) NULL,
	[transaction_status] [varchar](255) NULL,
	[transaction_type] [varchar](255) NULL,
	[transaction_user] [varchar](255) NULL,
	[transaction_value_date] [varchar](255) NULL,
	[unique_id_1] [varchar](255) NULL,
	[unique_id_2] [varchar](255) NULL,
	[unique_id_3] [varchar](255) NULL,
	[vessel_name] [varchar](255) NULL,
	[str_seq] [varchar](255) NULL,
	[is_stakeholder_pep] [varchar](100) NULL,
	[name_of_stakeholders] [varchar](max) NULL,
	[forex_transactions] [varchar](max) NULL,
	[remitter_country] [varchar](255) NULL,
	[beneficiary_nationality] [varchar](255) NULL,
	[remitter_year_of_birth] [varchar](255) NULL,
	[remitter_identification_number] [varchar](255) NULL,
	[remitter_sensitivity] [varchar](255) NULL,
	[remitter_match_type] [varchar](255) NULL,
	[remitter_risk_category] [varchar](255) NULL,
	[remitter_type_desc] [varchar](255) NULL,
	[remitter_list_source] [varchar](255) NULL,
	[remitter_list_sub_cat] [varchar](255) NULL,
	[beneficiary_year_of_birth] [varchar](255) NULL,
	[beneficiary_identification_number] [varchar](255) NULL,
	[beneficiary_sensitivity] [varchar](255) NULL,
	[beneficiary_match_type] [varchar](255) NULL,
	[beneficiary_risk_category] [varchar](255) NULL,
	[beneficiary_type_desc] [varchar](255) NULL,
	[beneficiary_list_source] [varchar](255) NULL,
	[beneficiary_list_sub_cat] [varchar](255) NULL,
	[date_time] [datetime2](7) NULL,
	[remitter_nationality_screening] [varchar](255) NULL,
	[beneficiary_nationality_screening] [varchar](255) NULL,
	[stakeholder_match_flag] [bit] NULL,
	[bank_name_match_flag] [bit] NULL,
	[vessel_match_flag] [bit] NULL,
	[is_rule_violation] [bit] NULL,
	[annual_threshold_amount] [varchar](255) NULL,
	[annual_threshold_count] [varchar](255) NULL,
	[beneficiary_nationality_risk] [varchar](255) NULL,
	[is_employee_flag] [varchar](255) NULL,
	[is_seamen] [varchar](255) NULL,
	[is_walk_in_flag] [varchar](255) NULL,
	[istr_flag] [varchar](255) NULL,
	[remitter_account_number] [varchar](255) NULL,
	[remitter_nationality_currency] [varchar](255) NULL,
	[remitter_nationality_risk] [varchar](255) NULL,
	[str_flag] [varchar](255) NULL,
	[rule_name] [varchar](255) NULL,
	[rule_1_triggering_text] [varchar](250) NULL,
	[rule_1_triggering_value] [numeric](18, 2) NULL,
	[rule_1] [numeric](18, 0) NULL,
	[rule_2] [numeric](18, 2) NULL,
	[rule_2_triggering_text] [varchar](255) NULL,
	[rule_2_triggering_value] [numeric](18, 4) NULL,
	[rule_3] [numeric](18, 2) NULL,
	[rule_3_triggering_text] [varchar](255) NULL,
	[rule_3_triggering_value] [numeric](18, 4) NULL,
	[rule_4] [numeric](18, 2) NULL,
	[rule_4_triggering_text] [varchar](255) NULL,
	[rule_4_triggering_value] [numeric](18, 4) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[world_check_keywords]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[world_check_keywords](
	[Keyword] [nvarchar](250) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[list_history] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[list_lookup_table] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[message_list] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[message_list] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [remitter_name]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [remitter_nationality]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [remitter_date_of_birth]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [remitter_year_of_birth]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [remitter_identification_no]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [beneficiary_name]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [beneficiary_nationality]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [beneficiary_date_of_birth]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [beneficiary_year_of_birth]
GO
ALTER TABLE [dbo].[swift] ADD  DEFAULT ((1)) FOR [beneficiary_identification_no]
GO
ALTER TABLE [dbo].[common_file_upload_request]  WITH CHECK ADD  CONSTRAINT [FKhso3xkbnp850s3tumssb901db] FOREIGN KEY([request_id])
REFERENCES [dbo].[request_master] ([request_id])
GO
ALTER TABLE [dbo].[common_file_upload_request] CHECK CONSTRAINT [FKhso3xkbnp850s3tumssb901db]
GO
ALTER TABLE [dbo].[list_data]  WITH CHECK ADD  CONSTRAINT [FKkp3yc491yfkol58w9f0dj7tgc] FOREIGN KEY([list_master_sno])
REFERENCES [dbo].[list_master] ([list_master_sno])
GO
ALTER TABLE [dbo].[list_data] CHECK CONSTRAINT [FKkp3yc491yfkol58w9f0dj7tgc]
GO
ALTER TABLE [dbo].[list_data_request]  WITH CHECK ADD  CONSTRAINT [FKolm5lyr6rcl5xfls0mbiyxgu3] FOREIGN KEY([request_id])
REFERENCES [dbo].[request_master] ([request_id])
GO
ALTER TABLE [dbo].[list_data_request] CHECK CONSTRAINT [FKolm5lyr6rcl5xfls0mbiyxgu3]
GO
ALTER TABLE [dbo].[list_data_request_bkp]  WITH CHECK ADD  CONSTRAINT [FKolm5lyr7rcl5xfls0mbiyxgu3] FOREIGN KEY([request_id])
REFERENCES [dbo].[request_master] ([request_id])
GO
ALTER TABLE [dbo].[list_data_request_bkp] CHECK CONSTRAINT [FKolm5lyr7rcl5xfls0mbiyxgu3]
GO
ALTER TABLE [dbo].[list_data_version]  WITH CHECK ADD  CONSTRAINT [FKeg5qd4sw98utjlk90itpposlr] FOREIGN KEY([list_master_sno])
REFERENCES [dbo].[list_master] ([list_master_sno])
GO
ALTER TABLE [dbo].[list_data_version] CHECK CONSTRAINT [FKeg5qd4sw98utjlk90itpposlr]
GO
ALTER TABLE [dbo].[list_data_version]  WITH CHECK ADD  CONSTRAINT [FKtbn4c5f2wtnmyc5cm7a4aro1i] FOREIGN KEY([list_data_sno])
REFERENCES [dbo].[list_data] ([list_data_sno])
GO
ALTER TABLE [dbo].[list_data_version] CHECK CONSTRAINT [FKtbn4c5f2wtnmyc5cm7a4aro1i]
GO
ALTER TABLE [dbo].[list_version]  WITH CHECK ADD  CONSTRAINT [FK381xfr8g6amcajdxafyja4c0v] FOREIGN KEY([list_master_sno])
REFERENCES [dbo].[list_master] ([list_master_sno])
GO
ALTER TABLE [dbo].[list_version] CHECK CONSTRAINT [FK381xfr8g6amcajdxafyja4c0v]
GO
ALTER TABLE [dbo].[matching_attrib_conf_version]  WITH CHECK ADD  CONSTRAINT [FKfvxq1881fbk90sf1dhpoywnf6] FOREIGN KEY([mac_sno])
REFERENCES [dbo].[matching_attribute_config] ([mac_sno])
GO
ALTER TABLE [dbo].[matching_attrib_conf_version] CHECK CONSTRAINT [FKfvxq1881fbk90sf1dhpoywnf6]
GO
ALTER TABLE [dbo].[matching_outcome]  WITH CHECK ADD  CONSTRAINT [FK2q2ap5l2tjuc79no7f8sj7s2n] FOREIGN KEY([customer_id])
REFERENCES [dbo].[sanction_customer] ([customer_id])
GO
ALTER TABLE [dbo].[matching_outcome] CHECK CONSTRAINT [FK2q2ap5l2tjuc79no7f8sj7s2n]
GO
ALTER TABLE [dbo].[matching_outcome]  WITH CHECK ADD  CONSTRAINT [FKlgej1uehomdf8lgdqegvfmil] FOREIGN KEY([entity_list_num])
REFERENCES [dbo].[list_data] ([entity_list_num])
GO
ALTER TABLE [dbo].[matching_outcome] CHECK CONSTRAINT [FKlgej1uehomdf8lgdqegvfmil]
GO
ALTER TABLE [dbo].[message_list]  WITH CHECK ADD  CONSTRAINT [FK_message_list_swift] FOREIGN KEY([swift_id])
REFERENCES [dbo].[swift] ([swift_id])
GO
ALTER TABLE [dbo].[message_list] CHECK CONSTRAINT [FK_message_list_swift]
GO
ALTER TABLE [dbo].[sanction_customer_version]  WITH CHECK ADD  CONSTRAINT [FKfm6xrki7cug44u8l4bpnkr29o] FOREIGN KEY([sc_sno])
REFERENCES [dbo].[sanction_customer] ([san_cust_sno])
GO
ALTER TABLE [dbo].[sanction_customer_version] CHECK CONSTRAINT [FKfm6xrki7cug44u8l4bpnkr29o]
GO
ALTER TABLE [dbo].[score_mapping]  WITH CHECK ADD  CONSTRAINT [FK6lrbm0aipranajpvsekdnjv2zabc] FOREIGN KEY([response_sno])
REFERENCES [dbo].[sanction_response_ns] ([response_sno])
GO
ALTER TABLE [dbo].[score_mapping] CHECK CONSTRAINT [FK6lrbm0aipranajpvsekdnjv2zabc]
GO
ALTER TABLE [dbo].[score_mapping_bkp_2025_06_12]  WITH CHECK ADD  CONSTRAINT [FK6lrbm0aipranajpvsekdnjv2y] FOREIGN KEY([response_sno])
REFERENCES [dbo].[sanction_response_ns_bkp_2025_06_12] ([response_sno])
GO
ALTER TABLE [dbo].[score_mapping_bkp_2025_06_12] CHECK CONSTRAINT [FK6lrbm0aipranajpvsekdnjv2y]
GO
ALTER TABLE [dbo].[score_mapping_transaction]  WITH CHECK ADD  CONSTRAINT [FK399cglyuanc8ngees4e9qgvm8] FOREIGN KEY([response_sno])
REFERENCES [dbo].[sanction_transaction_response] ([response_sno])
GO
ALTER TABLE [dbo].[score_mapping_transaction] CHECK CONSTRAINT [FK399cglyuanc8ngees4e9qgvm8]
GO
/****** Object:  StoredProcedure [dbo].[cbuae_load_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cbuae_load_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_archive_test] 
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT_TEST where LIST_SOURCE='CBUAELTL'  )

	delete from LIST_DATA_WCHT_TEST	where  LIST_SOURCE='CBUAELTL'

END
GO
/****** Object:  StoredProcedure [dbo].[cust_ind_screening_report]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cust_ind_screening_report] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select t1.Kyc_request_id as Request_ref_no ,
t3.File_id,
t1.Branch_code,
t1.Created_dttm as Registration_date_time,
t1.email_id as Customer_code,
t1.Customer_name,
t1.segment as Customer_type,
t2.screening as Screening_result,
t8.entity_name as Matched_name,
t8.Entity_watch_list_number,
t8.DOB,
t8.NATIONALITY_COUNTRY_NAME as Nationality,
t7.name_score as Match_score,
t8.exclude_ind as Alias_flag,
t8.LIST_SOURCE as Watch_list_name,
t8.TYPE_DESC as Customer_type,
t3.created_by as Initial_investigator,
t2.updated_by  as Approved_by,
t2.risk_score_ml as Customer_risk_score,
t2.triggering_value_text as Customer_risk_category,dbo.close_status(t2.FILE_ID) as Final_decision,
(select updated_dt as approve_date_time from file_active where updated_dt<>created_dt and file_id=t2.file_id)Approve_date_time,t2.reason as Closing_remarks from kyc.kyc.kyc_request as t1 
inner join file_active as t2 
on t1.kyc_request_id=t2.request_ref_no
left outer join event_master as t3 on t2.FILE_ID=t3.file_id 
inner join dev_sanctions.dbo.sanction_request_ns as t5 on t1.unique_number=t5.request_id
inner join dev_sanctions.dbo.sanction_response_ns as t6 on t5.screq_sno=t6.request_ref_no inner join dev_sanctions.dbo.score_mapping as t7 on t6.response_sno=t7.response_sno
inner join dev_sanctions.dbo.list_data_wcht as t8 on t7.watch_list_key=t8.entity_watch_list_key
where t2.file_type='CDD' and t2.screening='Watchlist match during name screening' 
and t3.created_dttm=(select created_dttm from (SELECT  created_dttm,row_number() over (order by created_dttm) rnk FROM event_master where created_dttm is not null and file_id=t2.file_id
)a where rnk=1) and t2.created_dt>='2022-08-01' and t2.created_dt<'2022-09-01' and t1.segment='Individual' order by t3.file_id
END
GO
/****** Object:  StoredProcedure [dbo].[customer_screening_report]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[customer_screening_report]
AS 
insert into TestTable (list_name) 
select list_name from incremental_refresh_audit
where id=1;
GO
/****** Object:  StoredProcedure [dbo].[customer_screening_report_individual]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[customer_screening_report_individual]
    @LookbackPeriod VARCHAR(10) = 'Daily',  -- Accepts 'Daily' or 'Monthly'
    @Environment VARCHAR(10)                -- Accepts 'dev', 'uat', 'prod'
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate @Environment input to prevent SQL injection
    IF @Environment NOT IN ('dev', 'uat', 'prod')
    BEGIN
        RAISERROR('Invalid environment specified. Allowed values are dev, uat, prod.', 16, 1);
        RETURN;
    END

    DECLARE @start_date DATETIME;
    DECLARE @end_date DATETIME;

    -- Determine the date range based on the input parameter
    IF @LookbackPeriod = 'Daily'
    BEGIN
        -- T-1 day
        SET @start_date = DATEADD(DAY, -1, CAST(GETDATE() AS DATE));
        SET @end_date = CAST(GETDATE() AS DATE);
    END
    ELSE IF @LookbackPeriod = 'Monthly'
    BEGIN
        -- T-30 days
        SET @start_date = DATEADD(DAY, -30, CAST(GETDATE() AS DATE));
        SET @end_date = CAST(GETDATE() AS DATE);
    END
    ELSE
    BEGIN
        -- Default to Daily if invalid parameter supplied
        SET @start_date = DATEADD(DAY, -1, CAST(GETDATE() AS DATE));
        SET @end_date = CAST(GETDATE() AS DATE);
    END

    -- Construct database name prefixes based on environment
    DECLARE @kyc_db NVARCHAR(128);
    IF @Environment = 'dev'
        SET @kyc_db = QUOTENAME('kyc');  -- No prefix for dev environment
    ELSE
        SET @kyc_db = QUOTENAME(@Environment + '_kyc');  -- Prefix for uat and prod

    DECLARE @sanctions_db NVARCHAR(128) = QUOTENAME(@Environment + '_sanctions');
    DECLARE @casemgmt_db NVARCHAR(128) = QUOTENAME(@Environment + '_casemgmt');

    -- Define fully qualified table names with schema
    DECLARE @kyc_request_alamal NVARCHAR(256) = @kyc_db + '.kyc.kyc_request_alamal';
    DECLARE @file_active_table NVARCHAR(256) = @casemgmt_db + '.dbo.file_active';
    DECLARE @event_master_table NVARCHAR(256) = @casemgmt_db + '.dbo.event_master';
    DECLARE @sanction_request_ns NVARCHAR(256) = @sanctions_db + '.dbo.sanction_request_ns';
    DECLARE @sanction_response_ns NVARCHAR(256) = @sanctions_db + '.dbo.sanction_response_ns';
    DECLARE @score_mapping NVARCHAR(256) = @sanctions_db + '.dbo.score_mapping';
    DECLARE @list_data_wcht NVARCHAR(256) = @sanctions_db + '.dbo.list_data_wcht';

    -- Build the dynamic SQL query
    DECLARE @sql NVARCHAR(MAX) = N'
    SELECT 
        t1.Kyc_request_id AS Request_ref_no,
        t3.File_id,
        t1.Branch,
        t1.Created_dttm AS Registration_date_time,
        t2.cust_primary_number AS Customer_code,
        t2.cust_primary_name AS Customer_name,
        t1.customer_type AS Customer_type,
        t1.name_match AS Screening_result,
        t8.entity_name AS Matched_name,
        t8.Entity_watch_list_number,
        t8.DOB,
        t8.NATIONALITY_COUNTRY_NAME AS Nationality,
        t7.name_score AS Match_score,
        t8.exclude_ind AS Alias_flag,
        t8.LIST_SOURCE AS Watch_list_name,
        t8.TYPE_DESC AS Customer_type,
        t3.created_by AS Initial_investigator,
        t2.updated_by AS Approved_by,
        t1.risk_score AS Customer_risk_score,
        t1.risk_band AS Customer_risk_category,
        dbo.close_status(t2.FILE_ID) AS Final_decision,
        (
            SELECT updated_dt 
            FROM ' + @file_active_table + ' 
            WHERE updated_dt <> created_dt AND file_id = t2.file_id
        ) AS Approve_date_time,
        t2.reason AS Closing_remarks
    FROM ' + @kyc_request_alamal + ' AS t1
    INNER JOIN ' + @file_active_table + ' AS t2 ON t1.kyc_request_id = t2.request_ref_no
    LEFT OUTER JOIN ' + @event_master_table + ' AS t3 ON t2.FILE_ID = t3.file_id
    INNER JOIN ' + @sanction_request_ns + ' AS t5 ON t1.unique_number = t5.request_id
    INNER JOIN ' + @sanction_response_ns + ' AS t6 ON t5.screq_sno = t6.request_ref_no
    INNER JOIN ' + @score_mapping + ' AS t7 ON t6.response_sno = t7.response_sno
    INNER JOIN ' + @list_data_wcht + ' AS t8 ON t7.watch_list_key = t8.entity_watch_list_key
    WHERE t2.file_type = ''CDD''
      AND t3.created_dttm = (
            SELECT created_dttm 
            FROM (
                SELECT created_dttm, ROW_NUMBER() OVER (ORDER BY created_dttm) AS rnk 
                FROM ' + @event_master_table + ' 
                WHERE created_dttm IS NOT NULL 
                  AND file_id = t2.file_id
            ) a
            WHERE rnk = 1
        )
      AND t2.created_dt >= @start_date
      AND t2.created_dt < @end_date
      AND t1.customer_type = ''Corporate''
    ORDER BY t3.file_id;
    ';

    -- Execute the dynamic SQL with parameters for date range
    EXEC sp_executesql 
        @sql,
        N'@start_date DATETIME, @end_date DATETIME',
        @start_date = @start_date,
        @end_date = @end_date;
END;
GO
/****** Object:  StoredProcedure [dbo].[customer_screening_report_stakeholder]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[customer_screening_report_stakeholder]
    @LookbackPeriod VARCHAR(10) = 'Daily',  -- Accepts 'Daily' or 'Monthly'
    @Environment VARCHAR(10)                -- Accepts 'dev', 'uat', 'prod'
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate @Environment input to prevent SQL injection
    IF @Environment NOT IN ('dev', 'uat', 'prod')
    BEGIN
        RAISERROR('Invalid environment specified. Allowed values are dev, uat, prod.', 16, 1);
        RETURN;
    END

    DECLARE @start_date DATETIME;
    DECLARE @end_date DATETIME;

    -- Determine the date range based on the input parameter
    IF @LookbackPeriod = 'Daily'
    BEGIN
        -- T-1 day
        SET @start_date = DATEADD(DAY, -1, CAST(GETDATE() AS DATE));
        SET @end_date = CAST(GETDATE() AS DATE);
    END
    ELSE IF @LookbackPeriod = 'Monthly'
    BEGIN
        -- T-30 days
        SET @start_date = DATEADD(DAY, -30, CAST(GETDATE() AS DATE));
        SET @end_date = CAST(GETDATE() AS DATE);
    END
    ELSE
    BEGIN
        -- Default to Daily if invalid parameter supplied
        SET @start_date = DATEADD(DAY, -1, CAST(GETDATE() AS DATE));
        SET @end_date = CAST(GETDATE() AS DATE);
    END

    -- Construct database name prefixes based on environment
    DECLARE @kyc_db NVARCHAR(128);
    IF @Environment = 'dev'
        SET @kyc_db = QUOTENAME('kyc');  -- No prefix for dev environment
    ELSE
        SET @kyc_db = QUOTENAME(@Environment + '_kyc');  -- Prefix for uat and prod

    DECLARE @sanctions_db NVARCHAR(128) = QUOTENAME(@Environment + '_sanctions');
    DECLARE @casemgmt_db NVARCHAR(128) = QUOTENAME(@Environment + '_casemgmt');

    -- Define fully qualified table names with schema
    DECLARE @kyc_request_alamal NVARCHAR(256) = @kyc_db + '.kyc.kyc_request_alamal';
	DECLARE @kyc_stakeholder_request_alamal NVARCHAR(256) = @kyc_db + '.kyc.kyc_stakeholder_request_alamal';
    DECLARE @file_active_table NVARCHAR(256) = @casemgmt_db + '.dbo.file_active';
    DECLARE @event_master_table NVARCHAR(256) = @casemgmt_db + '.dbo.event_master';
    DECLARE @sanction_request_ns NVARCHAR(256) = @sanctions_db + '.dbo.sanction_request_ns';
    DECLARE @sanction_response_ns NVARCHAR(256) = @sanctions_db + '.dbo.sanction_response_ns';
    DECLARE @score_mapping NVARCHAR(256) = @sanctions_db + '.dbo.score_mapping';
    DECLARE @list_data_wcht NVARCHAR(256) = @sanctions_db + '.dbo.list_data_wcht';

    -- Build the dynamic SQL query
    DECLARE @sql NVARCHAR(MAX) = N'
    SELECT 
        t1.Kyc_request_id AS Request_ref_no,
        t3.File_id,
        t1.Branch,
        t1.Created_dttm AS Registration_date_time,
        t2.cust_primary_number AS Customer_code,
        t2.cust_primary_name AS Customer_name,
        t1.customer_type AS Customer_type,
        t1.name_match AS Screening_result,
		t5.full_name as Entity_name,
        t8.entity_name AS Matched_name,
        t8.Entity_watch_list_number,
        t8.DOB,
        t8.NATIONALITY_COUNTRY_NAME AS Nationality,
        t7.name_score AS Match_score,
        t8.exclude_ind AS Alias_flag,
        t8.LIST_SOURCE AS Watch_list_name,
        t8.TYPE_DESC AS Customer_type,
        t3.created_by AS Initial_investigator,
        t2.updated_by AS Approved_by,
        t1.risk_score AS Customer_risk_score,
        t1.risk_band AS Customer_risk_category,
        dbo.close_status(t2.FILE_ID) AS Final_decision,
        (
            SELECT updated_dt 
            FROM ' + @file_active_table + ' 
            WHERE updated_dt <> created_dt AND file_id = t2.file_id
        ) AS Approve_date_time,
        t2.reason AS Closing_remarks
    FROM ' + @kyc_request_alamal + ' AS t1
    INNER JOIN ' + @file_active_table + ' AS t2 ON t1.kyc_request_id = t2.request_ref_no
    LEFT OUTER JOIN ' + @event_master_table + ' AS t3 ON t2.FILE_ID = t3.file_id
    INNER JOIN ' + @sanction_request_ns + ' AS t5 ON t1.unique_number_2 = t5.request_id
    INNER JOIN ' + @sanction_response_ns + ' AS t6 ON t5.screq_sno = t6.request_ref_no
    INNER JOIN ' + @score_mapping + ' AS t7 ON t6.response_sno = t7.response_sno
    INNER JOIN ' + @list_data_wcht + ' AS t8 ON t7.watch_list_key = t8.entity_watch_list_key
    WHERE t2.file_type = ''CDD''
      AND t3.created_dttm = (
            SELECT created_dttm 
            FROM (
                SELECT created_dttm, ROW_NUMBER() OVER (ORDER BY created_dttm) AS rnk 
                FROM ' + @event_master_table + ' 
                WHERE created_dttm IS NOT NULL 
                  AND file_id = t2.file_id
            ) a
            WHERE rnk = 1
        )
      AND t2.created_dt >= @start_date
      AND t2.created_dt < @end_date
      AND t1.customer_type = ''Corporate''
    ORDER BY t3.file_id;
    ';

    -- Execute the dynamic SQL with parameters for date range
    EXEC sp_executesql 
        @sql,
        N'@start_date DATETIME, @end_date DATETIME',
        @start_date = @start_date,
        @end_date = @end_date;
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_data_from_main_table_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[delete_data_from_main_table_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where Entity_watch_List_Key  IN

		 (select distinct uid from delete_data_temp ))

	delete from LIST_DATA_WCHT	 where entity_watch_list_key  in
 (select distinct uid from delete_data_temp )

delete from delete_data_temp

END
GO
/****** Object:  StoredProcedure [dbo].[delete_from_main_table_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[delete_from_main_table_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where Entity_watch_List_Number  IN

		 (select distinct entity_watch_list_number from delete_data_temp ))

	delete from LIST_DATA_WCHT	 where entity_watch_list_number  in
 (select distinct uid from delete_data_temp )

delete from delete_data_temp

END
GO
/****** Object:  StoredProcedure [dbo].[dow_jones_main_details_to_archive_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dow_jones_main_details_to_archive_procedure]
AS
BEGIN
    -- Insert data into archive table
    INSERT INTO [dbo].[dow_jones_details_master_archive]
    (
        [id],
        [entity_watch_list_number],
        [type_desc],
        [address_line],
        [address_city],
        [address_country],
        [url],
        [country_type],
        [country_code],
        [country_name],
        [id_type],
        [id_value],
        [id_notes],
        [image_url],
        [role_type],
        [occ_category],
        [occ_title],
        [since_day],
        [since_month],
        [since_year],
        [to_day],
        [to_month],
        [to_year],
        [reference_name],
        [source_name],
        [CREATED_DTTM],
        [UPDATED_DTTM],
        [created_date],
        [updated_date] 
    )
    SELECT
    	NEXT VALUE FOR dow_jones_details_master_archive_seq,
        [entity_watch_list_number],
        [type_desc],
        [address_line],
        [address_city],
        [address_country],
        [url],
        [country_type],
        [country_code],
        [country_name],
        [id_type],
        [id_value],
        [id_notes],
        [image_url],
        [role_type],
        [occ_category],
        [occ_title],
        [since_day],
        [since_month],
        [since_year],
        [to_day],
        [to_month],
        [to_year],
        [reference_name],
        [source_name],
        [CREATED_DTTM],
        GETUTCDATE(),
        [created_date],
        [updated_date] 
    FROM
        dow_jones_details_master_temp
    WHERE
        [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

    -- Delete entries from other tables based on entity_watch_list_number from dow_jones_details_master_temp
    DELETE FROM dowjones_address
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

    DELETE FROM dowjones_country_details
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);
	
   	DELETE FROM dowjones_id_details
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

   	DELETE FROM dowjones_image
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

   	DELETE FROM dowjones_role_type
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

   	DELETE FROM dowjones_sanctions
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

   	DELETE FROM dowjones_source_description
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM dow_jones_details_master_temp);

 	ALTER SEQUENCE dow_jones_look_up_seq RESTART WITH 1;
   -- Empty the temporary table
    DELETE FROM dow_jones_details_master_temp;
END
GO
/****** Object:  StoredProcedure [dbo].[dow_jones_main_to_del_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dow_jones_main_to_del_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
           ,[IS_PEP_FLAG]
           ,[IS_SANCTIONS_FLAG]
           ,[IS_ADVERSE_FLAG]
           ,[IS_SANCTION_REF_FLAG]
		   ,[entity_ref])
   ( select
          
           next value For dow_jones_list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
         ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
    ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
           ,[IS_PEP_FLAG]
           ,[IS_SANCTIONS_FLAG]
           ,[IS_ADVERSE_FLAG]
           ,[IS_SANCTION_REF_FLAG]
		   ,[entity_watch_list_key]

		   from list_data_wcht where Entity_watch_List_Number  IN

		 (select distinct entity_watch_list_number from dow_jones_list_data_wcht_del_temp  ))

	delete from list_data_wcht	 where entity_watch_list_number  in
 (select distinct entity_watch_list_number from dow_jones_list_data_wcht_del_temp )


delete from dow_jones_list_data_wcht_del_temp

END
GO
/****** Object:  StoredProcedure [dbo].[dow_jones_temp_to_main_table_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dow_jones_temp_to_main_table_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
           ,[IS_PEP_FLAG]
           ,[IS_SANCTIONS_FLAG]
           ,[IS_ADVERSE_FLAG]
           ,[IS_SANCTION_REF_FLAG]
		   ,[entity_ref])
   ( select
          
           next value For dow_jones_list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
,[FOURTH_NAME]
           ,[ENTITY_NAME]
       ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
    ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
           ,[IS_PEP_FLAG]
           ,[IS_SANCTIONS_FLAG]
           ,[IS_ADVERSE_FLAG]
           ,[IS_SANCTION_REF_FLAG]
		   ,[entity_watch_list_key]

		   from list_data_wcht_test where Entity_watch_List_Number  IN

		 (select distinct entity_watch_list_number from dow_jones_list_data_wcht_incr_temp  ))

	delete from list_data_wcht_test	 where entity_watch_list_number  in
 (select distinct entity_watch_list_number from dow_jones_list_data_wcht_incr_temp )
	
 	
 	INSERT INTO [dbo].[list_data_wcht_test]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
       ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
    ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
           ,[IS_PEP_FLAG]
           ,[IS_SANCTIONS_FLAG]
           ,[IS_ADVERSE_FLAG]
           ,[IS_SANCTION_REF_FLAG])
   ( select
          
           next value For dow_jones_list_data_wcht_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
        ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
       ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
           ,[Is_PEP_Flag]
           ,[Is_Sanctions_Flag]
           ,[IS_ADVERSE_FLAG]
           ,[IS_SANCTION_REF_FLAG]

		   from dow_jones_list_data_wcht_incr_temp )

delete from dow_jones_list_data_wcht_incr_temp

END
GO
/****** Object:  StoredProcedure [dbo].[eu_unload_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[eu_unload_procedure]
AS 
BEGIN
INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='EU'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='EU'

END
GO
/****** Object:  StoredProcedure [dbo].[fiu_list_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fiu_list_procedure]
AS 
BEGIN
INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='CB List'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='CB List'

END
GO
/****** Object:  StoredProcedure [dbo].[internal_load_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[internal_load_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='Internal'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='Internal'

END
GO
/****** Object:  StoredProcedure [dbo].[lexis_nexis_archive_master_table_procedure]    Script Date: 20-Jun-25 1:12:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[lexis_nexis_archive_master_table_procedure]
    @entityID VARCHAR(255)
AS 
BEGIN
    -- Insert data from additional tables into the archive table using the provided entityID

    -- Insert from lexis_nexis_additional_segments
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, field_name_value, last_updated, segment_type, created_date, created_dttm, updated_date, updated_dttm, table_type 
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        asg.entity_watch_list_number,
        asg.field_name_value,
        asg.last_updated,
        asg.segment_type,
        asg.created_date,
        asg.created_dttm,
        asg.updated_date,
        GETUTCDATE(),
        'Additional Segments'
    FROM dev_sanctions.dbo.lexis_nexis_additional_segments asg
    WHERE asg.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_address
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, address1, address2, address_type_desc, city, country, iso_standard, last_updated, postal_code, state_province_region, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        addr.entity_watch_list_number,
        addr.address1,
        addr.address2,
        addr.address_type_desc,
        addr.city,
        addr.country,
        addr.iso_standard,
        addr.last_updated,
        addr.postal_code,
        addr.state_province_region,
        addr.created_date,
        addr.created_dttm,
        addr.updated_date,
        GETUTCDATE(),
        'Address'
    FROM dev_sanctions.dbo.lexis_nexis_address addr
    WHERE addr.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_adverse_media
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, adverse_media_desc, entity_adverse_media_subcategories, last_updated, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        adv.entity_watch_list_number,
        adv.adverse_media_desc,
        adv.entity_adverse_media_subcategories,
        adv.last_updated,
        adv.created_date,
        adv.created_dttm,
        adv.updated_date,
        GETUTCDATE(),
        'Adverse Media'
    FROM dev_sanctions.dbo.lexis_nexis_adverse_media adv
    WHERE adv.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_country_association
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, administrative_unit_name, association_type_desc, iso_standard, last_updated, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        country.entity_watch_list_number,
        country.administrative_unit_name,
        country.association_type_desc,
        country.iso_standard,
        country.last_updated,
        country.created_date,
        country.created_dttm,
        country.updated_date,
        GETUTCDATE(),
        'Country Association'
    FROM dev_sanctions.dbo.lexis_nexis_country_association country
    WHERE country.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_enforcement
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, administrative_unit_name, enforcement_desc, entity_enforcement_subcategories, iso_standard, last_updated, source_name, source_name_abbrev, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        enf.entity_watch_list_number,
        enf.administrative_unit_name,
        enf.enforcement_desc,
        enf.entity_enforcement_subcategories,
        enf.iso_standard,
        enf.last_updated,
        enf.source_name,
        enf.source_name_abbrev,
        enf.created_date,
        enf.created_dttm,
        enf.updated_date,
        GETUTCDATE(),
        'Enforcement'
    FROM dev_sanctions.dbo.lexis_nexis_enforcement enf
    WHERE enf.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_entity_identification
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, administrative_unit_name, expiration_date, identification_issuer, identification_number, identification_type_desc, iso_standard, issue_date, last_updated, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        iden.entity_watch_list_number,
        iden.administrative_unit_name,
        iden.expiration_date,
        iden.identification_issuer,
        iden.identification_number,
        iden.identification_type_desc,
        iden.iso_standard,
        iden.issue_date,
        iden.last_updated,
        iden.created_date,
        iden.created_dttm,
        iden.updated_date,
        GETUTCDATE(),
        'Identification'
    FROM dev_sanctions.dbo.lexis_nexis_entity_identification iden
    WHERE iden.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_pep
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, administrative_unit, effective_date, effective_date_type_desc, entity_pep_subcategories, expiration_date, expiration_date_type_desc, governing_institution, governing_role, is_active_pep, is_in_country_pep_only, is_primary_pep, iso_administrative_unit_level0, last_updated, pep_admin_level_desc, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        pep.entity_watch_list_number,
        pep.administrative_unit,
        pep.effective_date,
        pep.effective_date_type_desc,
        pep.entity_pep_subcategories,
        pep.expiration_date,
        pep.expiration_date_type_desc,
        pep.governing_institution,
        pep.governing_role,
        pep.is_active_pep,
        pep.is_in_country_pep_only,
        pep.is_primary_pep,
        pep.iso_administrative_unit_level0,
        pep.last_updated,
        pep.pep_admin_level_desc,
        pep.created_date,
        pep.created_dttm,
        pep.updated_date,
        GETUTCDATE(),
        'PEP'
    FROM dev_sanctions.dbo.lexis_nexis_pep pep
    WHERE pep.entity_watch_list_number = @entityID;

    -- Insert from lexis_nexis_position
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, last_updated, [position], created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        pos.entity_watch_list_number,
        pos.last_updated,
        pos.[position],
        pos.created_date,
        pos.created_dttm,
        pos.updated_date,
        GETUTCDATE(),
        'Position'
    FROM dev_sanctions.dbo.lexis_nexis_position pos
    WHERE pos.entity_watch_list_number = @entityID;

    -- Insert data from lexis_nexis_relationship into the archive table
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, group_desc, ownership_percentage, related_entity_guid, relationship_desc, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        rel.entity_watch_list_number,
        rel.group_desc,
        rel.ownership_percentage,
        rel.related_entity_guid,
        rel.relationship_desc,
        rel.created_date,
        rel.created_dttm,
        rel.updated_date,
        GETUTCDATE(),
        'Relationship'
    FROM dev_sanctions.dbo.lexis_nexis_relationship rel
    WHERE rel.entity_watch_list_number = @entityID;

    -- Insert data from lexis_nexis_sanctions into the archive table
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, administrative_unit_name, consolidated_sanction, entity_watch_list_number, iso_standard, last_updated, source_name, source_name_abbrev, sub_category_label, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        sanc.administrative_unit_name,
        sanc.consolidated_sanction,
        sanc.entity_watch_list_number,
        sanc.iso_standard,
        sanc.last_updated,
        sanc.source_name,
        sanc.source_name_abbrev,
        sanc.sub_category_label,
        sanc.created_date,
        sanc.created_dttm,
        sanc.updated_date,
        GETUTCDATE(),
        'Sanction'
    FROM dev_sanctions.dbo.lexis_nexis_sanctions sanc
    WHERE sanc.entity_watch_list_number = @entityID;

    -- Insert data from lexis_nexis_soe into the archive table
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_soe_domains, entity_soe_subcategories, entity_watch_list_number, is_active, last_updated, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        soe.entity_soe_domains,
        soe.entity_soe_subcategories,
        soe.entity_watch_list_number,
        soe.is_active,
        soe.last_updated,
        soe.created_date,
        soe.created_dttm,
        soe.updated_date,
        GETUTCDATE(),
        'SOE'
    FROM dev_sanctions.dbo.lexis_nexis_soe soe
    WHERE soe.entity_watch_list_number = @entityID;

    -- Insert data from lexis_nexis_source_item into the archive table
    INSERT INTO dev_sanctions.dbo.lexis_nexis_details_master_archive (
        id, entity_watch_list_number, last_updated, source_uri, created_date, created_dttm, updated_date, updated_dttm, table_type
    )
    SELECT
        NEXT VALUE FOR dev_sanctions.dbo.lexis_nexis_details_master_archive_seq,
        src.entity_watch_list_number,
        src.last_updated,
        src.source_uri,
        src.created_date,
        src.created_dttm,
        src.updated_date,
        GETUTCDATE(),
        'Source Item'
    FROM dev_sanctions.dbo.lexis_nexis_source_item src
    WHERE src.entity_watch_list_number = @entityID;

    -- Delete processed data from the source tables
    DELETE FROM dev_sanctions.dbo.lexis_nexis_additional_segments
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_address
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_adverse_media
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_country_association
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_enforcement
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_entity_identification
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_pep
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_position
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_relationship
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_sanctions
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_soe
    WHERE entity_watch_list_number = @entityID;

    DELETE FROM dev_sanctions.dbo.lexis_nexis_source_item
    WHERE entity_watch_list_number = @entityID;
END;
GO
/****** Object:  StoredProcedure [dbo].[lexis_nexis_main_details_to_archive_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[lexis_nexis_main_details_to_archive_procedure]
AS
BEGIN
    -- Insert data into archive table
    INSERT INTO [dbo].[lexis_nexis_details_master_archive]
    (
        [id],
        [entity_watch_list_number],
        [entityguid],
        [field_name_value],
        [last_updated],
        [segment_type],
        [adverse_media_desc],
        [entity_adverse_media_subcategories],
        [administrative_unit_name],
        [enforcement_desc],
        [entity_enforcement_subcategories],
        [iso_standard],
        [source_name],
        [source_name_abbrev],
        [expiration_date],
        [identification_issuer],
        [identification_number],
        [identification_type_desc],
        [issue_date],
        [administrative_unit],
        [effective_date],
        [effective_date_type_desc],
        [entity_pep_subcategories],
        [expiration_date_type_desc],
        [governing_institution],
        [governing_role],
        [is_active_pep],
        [is_in_country_pep_only],
        [is_primary_pep],
        [iso_administrative_unit_level0],
        [pep_admin_level_desc],
        [position],
        [group_desc],
        [ownership_percentage],
        [related_entity_guid],
        [relationship_desc],
        [consolidated_sanction],
        [sub_category_label],
        [entity_soe_domains],
        [entity_soe_subcategories],
        [is_active],
        [source_uri],
        [address1],
        [address2],
        [address_type_desc],
        [city],
        [country],
        [postal_code],
        [state_province_region],
        [association_type_desc],
        [table_type],
        [CREATED_DTTM],
        [UPDATED_DTTM],
        [created_date],
        [updated_date] 
    )
    SELECT
    	NEXT VALUE FOR lexis_nexis_details_master_archive_seq,
        [entity_watch_list_number],
        [entityguid],
        [field_name_value],
        [last_updated],
        [segment_type],
        [adverse_media_desc],
        [entity_adverse_media_subcategories],
        [administrative_unit_name],
        [enforcement_desc],
        [entity_enforcement_subcategories],
        [iso_standard],
        [source_name],
        [source_name_abbrev],
        [expiration_date],
        [identification_issuer],
        [identification_number],
        [identification_type_desc],
        [issue_date],
        [administrative_unit],
        [effective_date],
        [effective_date_type_desc],
        [entity_pep_subcategories],
        [expiration_date_type_desc],
        [governing_institution],
        [governing_role],
        [is_active_pep],
        [is_in_country_pep_only],
        [is_primary_pep],
        [iso_administrative_unit_level0],
        [pep_admin_level_desc],
        [position],
        [group_desc],
        [ownership_percentage],
        [related_entity_guid],
        [relationship_desc],
        [consolidated_sanction],
        [sub_category_label],
        [entity_soe_domains],
        [entity_soe_subcategories],
        [is_active],
        [source_uri],
        [address1],
        [address2],
        [address_type_desc],
        [city],
        [country],
        [postal_code],
        [state_province_region],
        [association_type_desc],
        [table_type],
        [CREATED_DTTM],
        GETUTCDATE(),
        [created_date],
        [updated_date] 
    FROM
        lexis_nexis_details_master_temp
    WHERE
        [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

    -- Delete entries from other tables based on entity_watch_list_number from dow_jones_details_master_temp
    DELETE FROM lexis_nexis_additional_segments
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

    DELETE FROM lexis_nexis_adverse_media
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);
	
   	DELETE FROM lexis_nexis_enforcement
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

   	DELETE FROM lexis_nexis_entity_identification
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

   	DELETE FROM lexis_nexis_pep
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

   	DELETE FROM lexis_nexis_position
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

   	DELETE FROM lexis_nexis_relationship
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);
   
   	DELETE FROM lexis_nexis_sanctions
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);
   
   	DELETE FROM lexis_nexis_soe
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);
   
   	DELETE FROM lexis_nexis_source_item
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);
   
   	DELETE FROM lexis_nexis_address 
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);
   
   	DELETE FROM lexis_nexis_country_association 
    WHERE [entity_watch_list_number] IN (SELECT [entity_watch_list_number] FROM lexis_nexis_details_master_temp);

   -- Empty the temporary table
    DELETE FROM lexis_nexis_details_master_temp;
END
GO
/****** Object:  StoredProcedure [dbo].[lexis_nexis_main_to_del_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[lexis_nexis_main_to_del_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_archive_test]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
  ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from list_data_wcht_test where CUSTOMER_ID  IN

		 (select distinct CUSTOMER_ID from lexis_nexis_list_data_wcht_del_temp  ))

	delete from list_data_wcht_test	 where CUSTOMER_ID  in
 (select distinct CUSTOMER_ID from lexis_nexis_list_data_wcht_del_temp )


delete from lexis_nexis_list_data_wcht_del_temp

END
GO
/****** Object:  StoredProcedure [dbo].[lexis_nexis_temp_to_main_table_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[lexis_nexis_temp_to_main_table_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_archive_test]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
    ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from list_data_wcht_test where ENTITY_WATCH_LIST_NUMBER  IN

		 (select distinct ENTITY_WATCH_LIST_NUMBER from lexis_nexis_list_data_wcht_incr_temp  ))

	delete from list_data_wcht_test	 where ENTITY_WATCH_LIST_NUMBER  in
 (select distinct ENTITY_WATCH_LIST_NUMBER from lexis_nexis_list_data_wcht_incr_temp )
	
 	
 	INSERT INTO [dbo].[list_data_wcht_test]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
,[COUNTRY_CODE]
        ,[COUNTRY_NAME]
    ,[ADDRESS]
      ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth])
   ( select
          
           next value For list_data_wcht_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
  ,[IMO_Number]
   ,[LIST_CLASSIFICATION]
       ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]

		   from lexis_nexis_list_data_wcht_incr_temp )

delete from lexis_nexis_list_data_wcht_incr_temp

END
GO
/****** Object:  StoredProcedure [dbo].[ofacnonsdn_load_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ofacnonsdn_load_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
     ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='OFAC Non SDN'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='OFAC Non SDN'

END
GO
/****** Object:  StoredProcedure [dbo].[ofacsdn_load_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ofacsdn_load_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='OFAC SDN'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='OFAC SDN'

END
GO
/****** Object:  StoredProcedure [dbo].[pepuae_load_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pepuae_load_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive_test]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seqtest
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
      ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='UAE PEP List'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='UAE PEP List'

END
GO
/****** Object:  StoredProcedure [dbo].[profile_table_update_jkuae]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[profile_table_update_jkuae]
    @transactionRefNo NVARCHAR(MAX)
AS
BEGIN
    DECLARE @date DATE;
    SET @date = GETDATE(); -- Assuming current date

    MERGE INTO profile_table  AS target
    USING (
        SELECT
            tt.customer_code,
            @date AS Date,
            COUNT(CASE WHEN tt.transaction_type = 'tt' THEN 1 END) AS OutFreq,
            SUM(CASE WHEN tt.transaction_type = 'tt' THEN CAST(tt.transaction_amount_lcy AS FLOAT) ELSE 0 END) AS OutTotal,
            COUNT(CASE WHEN tt.transaction_type = 'tt' AND tt.spm_flag = 'No' THEN 1 END) AS SpmFlagNoFreq,
            SUM(CASE WHEN tt.transaction_type = 'tt' AND tt.spm_flag = 'No' THEN CAST(tt.transaction_amount_lcy  AS FLOAT) ELSE 0 END) AS SpmFlagNoOut,
            COUNT(CASE WHEN tt.transaction_type = 'tt' AND tt.spm_flag = 'Yes' AND tt.service_type = 'Card Payment' THEN 1 END) AS SpmFlagServiceTypeFreq,
            SUM(CASE WHEN tt.transaction_type = 'tt' AND tt.spm_flag = 'Yes' AND tt.service_type = 'Card Payment' THEN CAST(tt.transaction_amount_lcy AS FLOAT) ELSE 0 END) AS SpmFlagServiceTypeOut,
            COUNT(CASE WHEN tt.transaction_type = 'in' THEN 1 END) AS InFreq,
            SUM(CASE WHEN tt.transaction_type = 'in' THEN CAST(tt.transaction_amount_lcy AS FLOAT) ELSE 0 END) AS InTotal,
            COUNT(CASE WHEN tt.transaction_type = 'fx' THEN 1 END) AS FcyFreq,
            SUM(CASE WHEN tt.transaction_type = 'fx' THEN CAST(tt.transaction_amount_lcy AS FLOAT) ELSE 0 END) AS FcyTotal
        FROM
            transaction_table tt
        WHERE
            tt.transaction_ref_no  = @transactionRefNo
        GROUP BY
            tt.customer_code
    ) AS source
    ON target.cust_number = source.customer_code AND target.Date = source.Date
    WHEN MATCHED THEN
        UPDATE
        SET
            target.out_freq = ISNULL(source.OutFreq, 0),
            target.out_total = ISNULL(source.OutTotal, 0),
            target.spm_flag_no_freq = ISNULL(source.SpmFlagNoFreq, 0),
            target.spm_flag_no_out = ISNULL(source.SpmFlagNoOut, 0),
            target.spm_flag_service_type_freq = ISNULL(source.SpmFlagServiceTypeFreq, 0),
            target.spm_flag_service_type_out = ISNULL(source.SpmFlagServiceTypeOut, 0),
            target.in_freq = ISNULL(source.InFreq, 0),
            target.in_total = ISNULL(source.InTotal, 0),
            target.fcy_freq = ISNULL(source.FcyFreq, 0),
            target.fcy_total = ISNULL(source.FcyTotal, 0)
    WHEN NOT MATCHED THEN
        INSERT (cust_number, Date, out_freq, out_total, spm_flag_no_freq, spm_flag_no_out, spm_flag_service_type_freq, spm_flag_service_type_out, in_freq, in_total, fcy_freq, fcy_total)
        VALUES (source.customer_code, source.Date, ISNULL(source.OutFreq, 0), ISNULL(source.OutTotal, 0), ISNULL(source.SpmFlagNoFreq, 0), ISNULL(source.SpmFlagNoOut, 0),
                ISNULL(source.SpmFlagServiceTypeFreq, 0), ISNULL(source.SpmFlagServiceTypeOut, 0), ISNULL(source.InFreq, 0), ISNULL(source.InTotal, 0),
                ISNULL(source.FcyFreq, 0), ISNULL(source.FcyTotal, 0));
END;
GO
/****** Object:  StoredProcedure [dbo].[temp_to_main_table_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[temp_to_main_table_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
    ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where Entity_watch_List_Number  IN

		 (select distinct entity_watch_list_number from list_data_wcht_incr_temp  ))

	delete from LIST_DATA_WCHT	 where entity_watch_list_number  in
 (select distinct entity_watch_list_number from list_data_wcht_incr_temp )


  INSERT INTO [dbo].[LIST_DATA_WCHT]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
    ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth])
   ( select
          
           next value For list_data_wcht_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]

		   from list_data_wcht_incr_temp )

delete from list_data_wcht_incr_temp

END
GO
/****** Object:  StoredProcedure [dbo].[un_load_procedure]    Script Date: 20-Jun-25 1:12:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[un_load_procedure]
AS
--SET NOCOUNT ON
BEGIN

INSERT INTO [dbo].[list_data_wcht_Archive]
           ([ENTITY_WATCH_LIST_KEY]
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,[UPDATED_DTTM]
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_ref])
   ( select
          
           next value For list_data_wcht_archive_seq
           ,[CREATED_BY]
           ,[SYS_LOAD_DT]
           ,[UPDATED_BY]
           ,[SYS_UPDATE_DT]
           ,[PLACE_OF_BIRTH]
           ,[CITIZENSHIP_COUNTRY_CODE]
           ,[CITIZENSHIP_COUNTRY_NAME]
           ,[NATIONALITY_COUNTRY_CODE]
           ,[NATIONALITY_COUNTRY_NAME]
           ,[CONTACT_NUM_1]
           ,[CUSTOMER_ID]
           ,[DECEASED_IND]
           ,[DOB]
           ,[OCCUPATION_DESC]
           ,[EMPLOYMENT_TYP_SUB_CAT]
           ,[ENTITY_CAT]
           ,[ENTITY_WATCH_LIST_NUMBER]
           ,[ENTITY_SUB_CAT]
           ,[EXCLUDE_IND]
           ,[FIRST_NAME]
           ,[FOURTH_NAME]
           ,[ENTITY_NAME]
           ,[IDENTIFICATION_ID]
           ,[IDENTIFICATION_ID_2]
           ,[IDENTIFICATION_TYPE_DESC]
           ,[IDENTIFICATION_TYPE_DESC_2]
           ,[LAST_NAME]
           ,[LIST_CAT]
           ,[WATCH_LIST_NAME]
           ,[LIST_SOURCE]
           ,[LIST_SUB_CAT]
           ,[MAILING_ADDR_CITY]
           ,[MAILING_ADDR_CNTRY_CD]
           ,[MAILING_ADDR_CNTRY_NAME]
           ,[MAILING_ADDR_LINE_1]
           ,[MAILING_ADDR_LINE_2]
           ,[MAILING_ADDR_LINE_3]
           ,[MAILING_ADDR_POSTAL_CD]
           ,[MAILING_ADDR_STATE]
           ,[NATIONAL_ID]
           ,[ORG_COUNTRY_OF_BUSINESS_CODE]
           ,[ORG_COUNTRY_OF_BUSINESS_NAME]
           ,[CITY_NAME]
           ,[COUNTRY_CODE]
           ,[COUNTRY_NAME]
           ,[ADDRESS]
           ,[RESIDENTIAL_ADDR_LINE_2]
           ,[RESIDENTIAL_ADDR_LINE_3]
           ,[POSTAL_CODE]
           ,[STATE_NAME]
           ,[CATEGORY_DESC]
           ,[SECOND_NAME]
           ,[THIRD_NAME]
           ,[ENTITY_TITLE]
           ,[LIST_MASTER_SNO]
           ,[TYPE_DESC]
           ,[TAX_ID]
           ,[TAX_ID_TYPE_CODE]
           ,[YEAR_OF_BIRTH]
           ,[MIDDLE_NAME]
           ,[FULL_ADDRESS]
           ,[POLITICALLY_EXPOSED_PERSON_IND]
           ,[SANCTION_TYPE]
           ,[CIRCULAR_DATE]
           ,[CHANGE_BEGIN_DATE]
           ,[CHANGE_END_DATE]
           ,[CHANGE_CURRENT_IND]
           ,[UMBRELLA_KEYWORD]
           ,[PROGRAMS]
           ,[CREATED_DT]
           ,[UPDATED_DT]
           ,[VESS_TYPE]
           ,[TONNAGE]
           ,[GRT]
           ,[VESS_COUNTRY]
           ,[VESS_OWNER]
           ,[REMARKS_1]
           ,[REMARKS_2]
           ,[IMO_Number]
           ,[LIST_CLASSIFICATION]
           ,[CREATED_DTTM]
           ,GETUTCDATE()
           ,[CASE_ID]
           ,[CONTACT_NUM_2]
           ,[SCREENING_SUB_CAT]
           ,[STATUS]
           ,[TRANSACTION_NO]
           ,[BIC_CODE]
           ,[SAMA_CIRCULAR_NUMBER]
           ,[TITLE]
           ,[REQUEST_REF]
           ,[UNTM_UPDATE_FLG]
           ,[MATCH_CODE_FLG]
           ,[Account_Number]
           ,[CNTRY_OF_CITIZENSHIP_2_CD]
           ,[CNTRY_OF_CITIZENSHIP_2_NAME]
           ,[date_of_birth]
		   ,[entity_watch_list_key]

		   from LIST_DATA_WCHT where LIST_SOURCE='UN List'  )

	delete from LIST_DATA_WCHT	 where  LIST_SOURCE='UN List'

END
GO
