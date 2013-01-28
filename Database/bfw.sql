/******************************************************************************/
/***          Generated by IBExpert 2012.10.08 28.01.2013 11:35:44          ***/
/******************************************************************************/

SET NAMES WIN1251;

CONNECT '192.168.0.5:b52' USER 'SYSDBA';



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE BFW_ENT (
    ENTITYNAME   VARCHAR(38) NOT NULL,
    SCHEMENAME   VARCHAR(38),
    IS_SCHEME    INTEGER DEFAULT 0 NOT NULL,
    DESCRIPTION  VARCHAR(250)
);


CREATE TABLE BFW_ENT_FIELDS (
    ENTITYNAME      VARCHAR(38) NOT NULL,
    VIEWNAME        VARCHAR(38) NOT NULL,
    FIELDNAME       VARCHAR(38) NOT NULL,
    BAND            VARCHAR(50),
    TITLE           VARCHAR(50),
    VISIBLE         INTEGER DEFAULT 1 NOT NULL,
    READONLY        INTEGER DEFAULT 0 NOT NULL,
    EDITOR          VARCHAR(50),
    EDITOR_OPTIONS  VARCHAR(1024),
    OPTIONS         VARCHAR(1024),
    REQ             INTEGER DEFAULT 0 NOT NULL
);


CREATE TABLE BFW_ENT_VIEW_LINKS (
    ENTITYNAME         VARCHAR(38) NOT NULL,
    VIEWNAME           VARCHAR(38) NOT NULL,
    LINKED_ENTITYNAME  VARCHAR(38) NOT NULL,
    LINKED_VIEWNAME    VARCHAR(38) NOT NULL,
    LINKED_FIELD       VARCHAR(38)
);


CREATE TABLE BFW_ENT_VIEWS (
    ENTITYNAME     VARCHAR(38) NOT NULL,
    VIEWNAME       VARCHAR(38) NOT NULL,
    SQL_SELECT     VARCHAR(1024),
    SQL_INSERT     VARCHAR(1024),
    SQL_INSERTDEF  VARCHAR(1024),
    SQL_UPDATE     VARCHAR(1024),
    SQL_DELETE     VARCHAR(1024),
    SQL_REFRESH    VARCHAR(1024),
    SQL_TITLE      VARCHAR(1024),
    READONLY       INTEGER DEFAULT 1 NOT NULL,
    PKEY           VARCHAR(38),
    IS_EXEC        INTEGER DEFAULT 0 NOT NULL,
    TITLE          VARCHAR(50),
    OPTIONS        VARCHAR(1024)
);


CREATE TABLE BFW_UI (
    URI         VARCHAR(50) NOT NULL,
    CLS         VARCHAR(50) NOT NULL,
    ENTITYNAME  VARCHAR(50) NOT NULL,
    VIEWNAME    VARCHAR(50),
    TITLE       VARCHAR(50) NOT NULL,
    GRP         VARCHAR(50),
    MENUIDX     INTEGER DEFAULT 0 NOT NULL,
    OPTIONS     VARCHAR(1024),
    PARAMS      VARCHAR(1024),
    OUTS        VARCHAR(1024),
    USEPERM     INTEGER DEFAULT 0 NOT NULL,
    PKG         VARCHAR(50)
);


CREATE TABLE BFW_UI_CLS (
    CLS          VARCHAR(50) NOT NULL,
    VIEWNAME     VARCHAR(50) NOT NULL,
    DESCRIPTION  VARCHAR(250),
    IMG          BLOB SUB_TYPE 0 SEGMENT SIZE 8192,
    OPTIONS      VARCHAR(1024)
);


CREATE TABLE BFW_UI_CMD (
    URI               VARCHAR(50) NOT NULL,
    CMD               VARCHAR(50) NOT NULL,
    CAPTION           VARCHAR(50) NOT NULL,
    IDX               INTEGER DEFAULT 0 NOT NULL,
    GRP               VARCHAR(50),
    DEF               INTEGER DEFAULT 0 NOT NULL,
    HANDLER           VARCHAR(1024),
    HANDLER_FOR       VARCHAR(1024),
    PARAMS            VARCHAR(1024),
    OPTIONS           VARCHAR(1024),
    CONDITION         VARCHAR(1024),
    CONDITION_PARAMS  VARCHAR(1024),
    SHORTCUT          VARCHAR(50)
);


CREATE TABLE BFW_UI_GRP (
    GRP  VARCHAR(50) NOT NULL,
    IDX  INTEGER
);


CREATE TABLE BFW_UI_STYLES (
    ID       VARCHAR(50) NOT NULL,
    OPTIONS  VARCHAR(1024)
);


INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_META', 'BFW', 0, NULL);
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_UI', 'BFW', 0, NULL);

COMMIT WORK;

INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_UI', 'List', 'select i.uri, i.cls, i.entityname, viewname,
           i.title, i.grp, i.menuidx, i.useperm,
           i.options, i.params, i.outs
    from bfw_ui i
           left join bfw_ui_grp g on (g.grp = i.grp)
    order by g.idx, i.menuidx, i.title', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_UI', 'Commands', 'select cmd.idx, cmd.* from bfw_ui_cmd cmd where cmd.uri = :uri
union
select cmd.idx, cmd.* from bfw_ui ui left join bfw_ui_cmd cmd on (cmd.uri = ui.cls)
where ui.uri = :uri and cmd.uri is not null
      and not exists(select * from bfw_ui_cmd cmdr where cmdr.uri = ui.uri and cmdr.cmd = cmd.cmd)
      and :APP_VER > 20120410
order by 1', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_UI', 'Styles', 'select * from bfw_ui_styles', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_META', 'Entities', 'select entityname from bfw_ent', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_META', 'Fields', 'select * from bfw_ent_fields where entityname = :entityname and viewname = :viewname', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_META', 'Entity', 'select * from bfw_ent where entityname = :entityname', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_META', 'View', 'select * from bfw_ent_views where entityname = :entityname and viewname = :viewname', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_META', 'ViewLinks', 'select * from bfw_ent_view_links where entityname = :entityname and viewname = :viewname', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_INSERTDEF, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, SQL_TITLE, READONLY, PKEY, IS_EXEC, TITLE, OPTIONS) VALUES ('BFW_META', 'ViewLinkedFields', 'select * from bfw_ent_view_links  where linked_entityname = :entityname and linked_viewname = :viewname and coalesce(linked_field, '''') <> ''''', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL);

COMMIT WORK;

INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityListView', 'List', '{Selector;SelectorInfo,NewURI,ItemURI}', NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityJournalView', 'Journal', 'States{Selector;SelectorInfo,NewURI,ItemURI}', NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityItemView', 'Item', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityNewView', 'New', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityComplexView', 'Head', 'Details{DetailNewURI,DetailItemURI}', NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityPickListView', 'PickList', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityOrgChartView', 'OrgChart', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntitySelectorView', 'Selector', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityItemExtView', 'ItemHead', 'ItemDetailEViews;ItemDetails', NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityActivity', '-', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityDeskView', 'Desk', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityCollectView', '-', 'CollectInfo;CollectList;CollectItems', NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityDeskMenuView', 'Items', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityTreeListView', 'List', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityOperExec', '-', NULL, NULL);
INSERT INTO BFW_UI_CLS (CLS, VIEWNAME, DESCRIPTION, OPTIONS) VALUES ('IEntityWebView', '-', NULL, NULL);

COMMIT WORK;



/******************************************************************************/
/***                           Unique Constraints                           ***/
/******************************************************************************/

ALTER TABLE BFW_ENT_VIEW_LINKS ADD CONSTRAINT UNQ1_BFW_ENT_VIEW_LINKS UNIQUE (ENTITYNAME, VIEWNAME, LINKED_ENTITYNAME, LINKED_VIEWNAME, LINKED_FIELD);


/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE BFW_ENT ADD CONSTRAINT PK_BFW_ENT PRIMARY KEY (ENTITYNAME);
ALTER TABLE BFW_ENT_FIELDS ADD CONSTRAINT PK_BFW_ENT_FIELDS PRIMARY KEY (ENTITYNAME, VIEWNAME, FIELDNAME);
ALTER TABLE BFW_ENT_VIEWS ADD CONSTRAINT PK_BFW_ENT_VIEWS PRIMARY KEY (ENTITYNAME, VIEWNAME);
ALTER TABLE BFW_UI ADD CONSTRAINT PK_BFW_UI PRIMARY KEY (URI);
ALTER TABLE BFW_UI_CLS ADD CONSTRAINT PK_BFW_UI_CLS PRIMARY KEY (CLS);
ALTER TABLE BFW_UI_CMD ADD CONSTRAINT PK_BFW_UI_CMD PRIMARY KEY (URI, CMD);
ALTER TABLE BFW_UI_GRP ADD CONSTRAINT PK_BFW_UI_GRP PRIMARY KEY (GRP);
ALTER TABLE BFW_UI_STYLES ADD CONSTRAINT PK_BFW_UI_STYLES PRIMARY KEY (ID);


/******************************************************************************/
/***                              Descriptions                              ***/
/******************************************************************************/

DESCRIBE TABLE BFW_UI_STYLES
'OPTIONS:
color={red,yellow,green etc... + InfoBk};
font.style={bold,italic,underline,strikeout};
font.color={color}

Use static:
Set in ENT_FIELDS.OPTIONS "Style=<id style>" for content and
  "Style.Header=<id style>" for header

Use dynamics:
In select or strored procedure define fields
 UI_ROW_STYLE for row style or UI_<FIELD_NAME>_STYLE for field style
 and set id style

Sample define style:
ID = "style1"
OPTIONS = "Color=InfoBk;Font.Style=Bold"';



/******************************************************************************/
/***                          Fields descriptions                           ***/
/******************************************************************************/

DESCRIBE FIELD HANDLER TABLE BFW_UI_CMD
'1) activity URI
2) command(s) separate by '','' or '';''';

DESCRIBE FIELD HANDLER_FOR TABLE BFW_UI_CMD
'command(s) id (CMD) separate by '','' or '';''';

DESCRIBE FIELD OPTIONS TABLE BFW_UI_CMD
'CloseViewBefore,CloseViewAfter,Hidden';

DESCRIBE FIELD CONDITION TABLE BFW_UI_CMD
'1) Entity=EntityName;EView=EntityViewName - sql must return integer value (0, 1)
2) empty - check by condition_params
Options:
RunOnce - check on UI first show
SetUnavailable - when condtion not passed set command state Unavailable';

DESCRIBE FIELD CONDITION_PARAMS TABLE BFW_UI_CMD
'1) Param1=Data1;Param2=Data2  (Param1, Param2 - sql params; Data1, Data2 - UI.Data)
2) Data1=[Value];Data2=NotEmpty (Data1, Data2 - UI.Data)';

