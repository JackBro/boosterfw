/******************************************************************************/
/***          Generated by IBExpert 2012.03.13 31.05.2012 17:29:00          ***/
/******************************************************************************/

SET NAMES WIN1251;

CONNECT '' USER 'SYSDBA';



SET TERM ^ ; 



/******************************************************************************/
/***                           Stored Procedures                            ***/
/******************************************************************************/

CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_ITEM (
    URI_ VARCHAR(50))
RETURNS (
    URI VARCHAR(50),
    CLS VARCHAR(50),
    TITLE VARCHAR(50),
    GRP VARCHAR(50),
    MENUIDX INTEGER,
    OPTIONS VARCHAR(1024),
    PARAMS VARCHAR(1024),
    OUTS VARCHAR(1024),
    USEPERM INTEGER,
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50),
    ENT_EVIEW VARCHAR(100),
    ENT_VIEW_READONLY INTEGER,
    ENT_VIEW_PKEY VARCHAR(50),
    ENT_SQL_SELECT VARCHAR(1024),
    ENT_SQL_INSERT VARCHAR(1024),
    ENT_SQL_INSERTDEF VARCHAR(1024),
    ENT_SQL_UPDATE VARCHAR(1024),
    ENT_SQL_DELETE VARCHAR(1024),
    ENT_SQL_REFRESH VARCHAR(1024),
    UI_TITLE VARCHAR(250))
AS
BEGIN
  SUSPEND;
END^





CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_ITEM_U (
    URI VARCHAR(50),
    TITLE VARCHAR(50),
    GRP VARCHAR(50),
    MENUIDX INTEGER,
    OPTIONS VARCHAR(1024),
    PARAMS VARCHAR(1024),
    OUTS VARCHAR(1024),
    USEPERM INTEGER,
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50),
    ENT_VIEW_READONLY INTEGER,
    ENT_VIEW_PKEY VARCHAR(50),
    ENT_SQL_SELECT VARCHAR(1024),
    ENT_SQL_INSERT VARCHAR(1024),
    ENT_SQL_INSERTDEF VARCHAR(1024),
    ENT_SQL_UPDATE VARCHAR(1024),
    ENT_SQL_DELETE VARCHAR(1024),
    ENT_SQL_REFRESH VARCHAR(1024))
AS
BEGIN
  EXIT;
END^





CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_NEW
RETURNS (
    URI VARCHAR(50),
    CLS VARCHAR(50),
    TITLE VARCHAR(50),
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50),
    ENT_EVIEW VARCHAR(100))
AS
BEGIN
  SUSPEND;
END^





CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_NEW_U (
    URI VARCHAR(50),
    CLS VARCHAR(50),
    TITLE VARCHAR(50),
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50))
AS
BEGIN
  EXIT;
END^






SET TERM ; ^

INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE', 'BFW_IDE', 0, 'BFW IDE');
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE_ENT', 'BFW_IDE', 0, '');
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE_EVIEW', 'BFW_IDE', 0, NULL);
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE_UI', 'BFW_IDE', 0, NULL);
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE_UI_CLS', 'BFW_IDE', 0, NULL);
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE_UI_FIELDS', 'BFW_IDE', 0, NULL);
INSERT INTO BFW_ENT (ENTITYNAME, SCHEMENAME, IS_SCHEME, DESCRIPTION) VALUES ('BFW_IDE_UI_CMD', 'BFW_IDE', 0, 'UI Commands');

COMMIT WORK;

INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_EVIEW', '-', 'SQL_SELECT', NULL, NULL, 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_EVIEW', '-', 'SQL_INSERT', NULL, NULL, 1, 0, 'MEMO', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_EVIEW', '-', 'SQL_UPDATE', NULL, NULL, 1, 0, 'MEMO', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_EVIEW', '-', 'SQL_REFRESH', NULL, NULL, 1, 0, 'MEMO', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'New', 'EVIEW', NULL, NULL, 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'URI', NULL, NULL, 1, 1, NULL, NULL, 'Style=Style.InfoBk', 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_SQL_SELECT', 'Entity', 'SQL Select', 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_SQL_UPDATE', 'Entity', 'SQL Update', 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'List', 'URI', NULL, NULL, 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'New', 'ENT', NULL, 'Entity', 1, 0, 'Lookup', 'Entity=BFW_IDE_ENT;EView=Lookup', NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT', 'Entity', NULL, 0, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'PKG', 'Misc', 'Package', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_VIEW', 'Entity', NULL, 0, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'GRP', 'Main menu', 'Group', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'MENUIDX', 'Main menu', 'Index', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_SQL_INSERT', 'Entity', 'SQL Insert', 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_SQL_DELETE', 'Entity', 'SQL Delete', 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_SQL_REFRESH', 'Entity', 'SQL Refresh', 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_SQL_INSERTDEF', 'Entity', 'SQL InsertDef', 1, 0, 'Memo', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'USEPERM', 'Misc', 'Use permission', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'PARAMS', 'IN OUT', 'Input params', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'OUTS', 'IN OUT', 'Output params', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_EVIEW', 'Entity', 'EntityView', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'CLS', NULL, 'Class', 1, 1, NULL, NULL, 'Style=Style.Bold', 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'TITLE', NULL, 'Title', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'OPTIONS', NULL, 'Options', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'New', 'CLS', NULL, 'Class', 1, 0, 'Lookup', 'Entity=BFW_IDE_UI_CLS;EView=Lookup', NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_VIEW_PKEY', 'Entity', 'Primary Keys', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'Item', 'ENT_VIEW_READONLY', 'Entity', 'ReadOnly', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'New', 'URI', NULL, NULL, 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI', 'List', 'MENUIDX', NULL, 'Menu Index', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_CLS', '-', 'IMG', NULL, 'UI View', 1, 0, 'Image', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_CLS', '-', 'CLS', NULL, 'Class', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'READONLY', NULL, 'ReadOnly', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'VISIBLE', '', 'Visible', 1, 0, 'CheckBox', 'AllowGrayed', NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'REQ', NULL, 'Required', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'ENTITYNAME', NULL, 'Entity', 1, 1, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'VIEWNAME', NULL, 'EntityView', 1, 1, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'FIELDNAME', NULL, 'FieldName', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'BAND', NULL, 'Band', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'TITLE', NULL, 'Title', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'VISIBLE', NULL, 'Visible', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'READONLY', NULL, 'ReadOnly', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'EDITOR', NULL, 'Editor', 1, 0, '', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'EDITOR_OPTIONS', NULL, 'EditorOptions', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'OPTIONS', NULL, 'Options', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'REQ', NULL, 'Required', 1, 0, 'CheckBox', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'ENTITYNAME', NULL, 'Entity', 1, 1, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'VIEWNAME', NULL, 'EntityView', 1, 1, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'FIELDNAME', NULL, 'FieldName', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'BAND', NULL, 'Band', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'TITLE', NULL, 'Title', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'EDITOR', NULL, 'Editor', 1, 0, '', NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'EDITOR_OPTIONS', NULL, 'EditorOptions', 1, 0, NULL, NULL, NULL, 0);
INSERT INTO BFW_ENT_FIELDS (ENTITYNAME, VIEWNAME, FIELDNAME, BAND, TITLE, VISIBLE, READONLY, EDITOR, EDITOR_OPTIONS, OPTIONS, REQ) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'OPTIONS', NULL, 'Options', 1, 0, NULL, NULL, NULL, 0);

COMMIT WORK;

INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_CLS', 'Item', 'select * from bfw_ui_cls where cls = :ID', NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_ENT', 'List', 'select * from bfw_ent order by entityname', NULL, NULL, NULL, 'select * from bfw_ent where entityname = :entityname', 1, 'entityname', NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_ENT', 'Item', 'select * from bfw_ent where entityname = :id', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_EVIEW', 'List', 'select * from bfw_ent_views ev  where entityname = :entityname', NULL, NULL, NULL, NULL, 1, 'viewname', NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_EVIEW', 'Item', 'select ev.*, ev.entityname || '':'' ||ev.viewname as ui_title 
from bfw_ent_views ev  
where entityname = :entityname and viewname = :viewname', NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI', 'TreeList', 'select distinct ui.pkg id, ui.pkg name, cast(null as varchar(50)) parent
from bfw_ui ui
where ui.pkg is not null
union all
select ui.uri, ui.title, ui.pkg parent
from bfw_ui ui
where ui.grp is not null
union all 
select distinct cast(''-'' as varchar(50)) id, cast(''-----'' as varchar(50)) name, cast(null as varchar(50)) parent
from bfw_ui ui
where ui.pkg is null
order by 2', NULL, NULL, NULL, '', 0, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI', 'Item', 'select * from bfw_ide_ev_ui_item(:uri)', NULL, 'execute procedure bfw_ide_ev_ui_item_u(:uri, :title, :grp, :menuidx, :options, 
:params, :outs, :useperm, :pkg, 
:ent, :ent_view, :ent_view_readonly, :ent_view_pkey, :ent_sql_select, :ent_sql_insert, :ent_sql_insertdef,
 :ent_sql_update,:ent_sql_delete,:ent_sql_refresh)', NULL, NULL, 0, 'uri', NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI', 'New', 'select * from bfw_ide_ev_ui_new', NULL, 'execute procedure bfw_ide_ev_ui_new_u(:uri, :cls, :title, :pkg, :ent, :ent_view)', NULL, NULL, 0, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI', 'List', 'select * from bfw_ui ui where coalesce(pkg, ''-'') = :pkg order by uri', NULL, NULL, NULL, 'select * from bfw_ui where uri = :uri', 1, 'uri', NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE', 'MainMenu', 'select uri, title from bfw_ui ui 
where ui.uri in (''views.BFW_IDE_UI.TreeList'', ''views.BFW_IDE_ENT.List'')', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE', 'Explorer', 'select * from bfw_ui', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_FIELDS', 'List', 'select * from bfw_ent_fields 
where entityname = :entityname 
            and (viewname = :viewname or viewname = ''-'')', NULL, '', NULL, 'select * from bfw_ent_fields f 
where f.entityname = :entityname and f.viewname = :viewname and f.fieldname = :fieldname', 1, 'FIELDNAME', NULL, 0, '');
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI', 'ItemURI', 'select cast(''views.BFW_IDE_UI.Item'' as varchar(50)) viewUri, pkg
from bfw_ui where uri = :uri
union
select distinct cast(''views.BFW_IDE_UI.List'' as varchar(50)) viewUri, coalesce(pkg, ''-'') pkg
from bfw_ui where coalesce(pkg, ''-'') = :uri', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_ENT', 'Lookup', 'select entityname id,  entityname name from bfw_ent where is_scheme = 0 order by entityname', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_CLS', 'Lookup', 'select cls id, cls name from bfw_ui_cls order by cls', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_FIELDS', 'Item', 'select * from bfw_ent_fields
where entityname = :entityname and viewname = :viewname and fieldname = :fieldname', NULL, 'update bfw_ent_fields 
set band = :band,  title = :title, visible = :visible, readonly = :readonly, req = :req,
       editor = :editor, editor_options = :editor_options, options = :options
where entityname = :entityname and viewname = :viewname and fieldname = :fieldname', NULL, NULL, 0, 'FIELDNAME', NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_FIELDS', 'New', 'select   f.*
from bfw_ent_fields f
where f.entityname = :entityname and f.viewname = :viewname and f.fieldname is null', 'insert into bfw_ent_fields(entityname, viewname, fieldname, band, title, visible, readonly, editor, editor_options, options, req )
values(:entityname, :viewname, :fieldname, :band, :title, :visible, :readonly, :editor, :editor_options, :options, :req)', '', NULL, NULL, 0, 'FIELDNAME', NULL, 0, 'select e.entityname, ev.viewname, cast(1 as integer) visible, cast(0 as integer) readonly, cast(0 as integer) req
from bfw_ent e left join bfw_ent_views ev on (e.entityname = ev.entityname)
where e.entityname = :entityname and ev.viewname = :viewname');
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI', 'ListTitle', 'select distinct coalesce(pkg, ''-'') title from bfw_ui where  coalesce(pkg, ''-'') = :pkg', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_ENT', 'New', 'select entityname, description from bfw_ent  where entityname is null', 'insert into bfw_ent(entityname, description, is_scheme)
values(:entityname, :description, 0)', NULL, NULL, NULL, 0, 'ENTITYNAME', NULL, 0, '');
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_CMD', 'List', 'select * from bfw_ui_cmd 
where uri = :uri
order by uri', NULL, NULL, NULL, 'select * from bfw_ui_cmd where uri = :uri and cmd = :cmd', 1, 'URI;CMD', NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_CMD', 'Item', 'select * from bfw_ui_cmd where uri = :uri and cmd = :cmd', NULL, 'update bfw_ui_cmd
set caption = :caption, idx = :idx, grp = :grp, def = :def,   
       params = :params,  outs = :outs,  handler = :handler , options = :options, 
       condition = :condition, condition_params = :condition_params
where uri = :uri and cmd = :cmd', NULL, NULL, 0, NULL, NULL, 0, NULL);
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_UI_CMD', 'New', 'select * from bfw_ui_cmd where uri = :uri and cmd is null', 'insert into bfw_ui_cmd(uri, cmd, caption, grp, def, idx, handler, params)
values(:uri, :cmd, :caption, :grp, :def, :idx, :handler, :params)', NULL, NULL, NULL, 0, 'URI;CMD', NULL, 0, 'select uri, cast(0 as integer) idx, cast(0 as integer) def from bfw_ui where uri = :uri');
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_EVIEW', 'New', 'select * from bfw_ent_views where entityname is null', 'insert into bfw_ent_views(entityname, viewname, sql_select) values(:entityname, :viewname, :sql_select)', NULL, NULL, NULL, 0, NULL, NULL, 0, '');
INSERT INTO BFW_ENT_VIEWS (ENTITYNAME, VIEWNAME, SQL_SELECT, SQL_INSERT, SQL_UPDATE, SQL_DELETE, SQL_REFRESH, READONLY, PKEY, OPTIONS, IS_EXEC, SQL_INSERTDEF) VALUES ('BFW_IDE_EVIEW', 'ListTitle', 'select entityname from bfw_entity where entityname = :entityname', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL);

COMMIT WORK;

INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE.Packages', 'IEntityListView', 'BFW_IDE', 'Packages', 'Packages', NULL, 0, NULL, NULL, NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_ENT.List', 'IEntityListView', 'BFW_IDE_ENT', 'List', 'Entities', NULL, 0, 'CanEdit', NULL, NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_ENT.Item', 'IEntityItemView', 'BFW_IDE_ENT', 'Item', 'Entity', NULL, 0, NULL, 'ID', NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_EVIEW.List', 'IEntityListView', 'BFW_IDE_EVIEW', 'List', 'EViews', NULL, 0, 'CanEdit;Title=ListTitle', 'ENTITYNAME', NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_EVIEW.Item', 'IEntityItemView', 'BFW_IDE_EVIEW', 'Item', 'EView', NULL, 0, NULL, 'ENTITYNAME;VIEWNAME', NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_CLS.Item', 'IEntityItemView', 'BFW_IDE_UI_CLS', 'Item', 'UI Class Item', NULL, 0, NULL, 'ID', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI.ListTop', 'IEntityListView', 'BFW_IDE_UI', 'List', '������������', '������', 0, 'CanEdit', NULL, NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI.List', 'IEntityListView', 'BFW_IDE_UI', 'List', 'UI List', NULL, 0, 'CanEdit;Title=ListTitle', 'PKG', NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI.New', 'IEntityNewView', 'BFW_IDE_UI', 'New', 'UI Item (New)', NULL, 0, 'Next', NULL, NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI.Item', 'IEntityItemView', 'BFW_IDE_UI', 'Item', 'UI Item', NULL, 0, NULL, 'URI', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_FIELDS.List', 'IEntityListView', 'BFW_IDE_UI_FIELDS', 'List', 'Fields for UI', NULL, 0, 'CanEdit', 'ENTITYNAME;VIEWNAME', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI.TreeList', 'IEntityTreeListView', 'BFW_IDE_UI', 'TreeList', 'UI', NULL, 0, 'CanOpen', NULL, NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE.MainMenu', 'IEntityDeskMenuView', 'BFW_IDE', 'MainMenu', '������������2', '������', 0, NULL, NULL, NULL, 1, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI.ItemQ', 'IEntityItemDef', 'BFW_IDE_UI', 'ItemURI', '-', NULL, 0, 'DefaultURI=views.%s.Item;EViewURI=ItemURI;EViewURIField=ViewURI', 'URI', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_EVIEW.New', 'IEntityNewView', 'BFW_IDE_EVIEW', 'New', 'New EView', NULL, 0, NULL, 'ENTITYNAME', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_FIELDS.Item', 'IEntityItemView', 'BFW_IDE_UI_FIELDS', 'Item', 'Entity view field', NULL, 0, NULL, 'ENTITYNAME,VIEWNAME,FIELDNAME', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_FIELDS.New', 'IEntityNewView', 'BFW_IDE_UI_FIELDS', 'New', 'New field for UI', '', 0, 'Next', 'ENTITYNAME,VIEWNAME', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_ENT.New', 'IEntityNewView', 'BFW_IDE_ENT', 'New', 'New Entity', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_CMD.List', 'IEntityListView', 'BFW_IDE_UI_CMD', 'List', 'UI Commands', NULL, 0, 'CanEdit', 'URI', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_CMD.Item', 'IEntityItemView', 'BFW_IDE_UI_CMD', 'Item', 'Command', NULL, 0, NULL, 'URI;CMD', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.BFW_IDE_UI_CMD.New', 'IEntityNewView', 'BFW_IDE_UI_CMD', 'New', 'UI Command (New)', NULL, 0, NULL, 'URI', NULL, 0, NULL);

COMMIT WORK;

INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_ENT.List', 'cmd.EView', 'Views', 0, NULL, 0, 'views.BFW_IDE_EVIEW.List', 'ENTITYNAME=ITEM_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI_CMD.List', 'commands.view.open', 'Open', 0, NULL, 0, 'views.BFW_IDE_UI_CMD.Item', 'URI=URI;CMD=EV.CMD', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.ListTop', 'cmd.ent.list', 'Entities', 0, NULL, 0, 'views.BFW_IDE_ENT.List', NULL, NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.ListTop', 'cmd.fields', 'Fields', 0, NULL, 0, 'views.BFW_IDE_UI_FIELDS.List', NULL, NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.ListTop', 'commands.view.open', 'Open1', 0, NULL, 0, 'views.BFW_IDE_UI.Item', 'URI=EV.URI', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.Item', 'cmd.fields', 'Fields', 0, NULL, 0, 'views.BFW_IDE_UI_FIELDS.List', 'ENTITYNAME=ENT;VIEWNAME=ENT_VIEW', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.Item', 'cmd.commands', 'Commands', 0, NULL, 0, 'views.BFW_IDE_UI_CMD.List', NULL, NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI_CMD.List', 'commands.view.new', 'Add', 0, NULL, 0, 'views.BFW_IDE_UI_CMD.New', 'URI=URI', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_EVIEW.List', 'commands.view.open', 'Open', 0, NULL, 0, 'views.BFW_IDE_EVIEW.Item', 'ENTITYNAME=EV.ENTITYNAME;VIEWNAME=EV.VIEWNAME', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI_FIELDS.List', 'commands.view.open', 'Open', 0, NULL, 0, 'views.BFW_IDE_UI_FIELDS.Item', 'ENTITYNAME=EV.ENTITYNAME;VIEWNAME=EV.VIEWNAME;FIELDNAME=EV.FIELDNAME', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.ListTop', 'cmd.tree', 'UI Tree', 0, NULL, 0, 'views.BFW_IDE_UI.TreeList', NULL, NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.TreeList', 'commands.view.open', 'Open', 0, NULL, 0, 'views.BFW_IDE_UI.ItemQ', 'URI=EV.ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI.List', 'commands.view.open', 'Open', 0, NULL, 0, 'views.BFW_IDE_UI.Item', 'URI=EV.URI', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('views.BFW_IDE_UI_FIELDS.List', 'commands.view.new', 'Add', 0, NULL, 0, 'views.BFW_IDE_UI_FIELDS.New', 'ENTITYNAME=ENTITYNAME;VIEWNAME=VIEWNAME', NULL, NULL, NULL, NULL);

COMMIT WORK;



/******************************************************************************/
/***                           Stored Procedures                            ***/
/******************************************************************************/


SET TERM ^ ;

CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_ITEM (
    URI_ VARCHAR(50))
RETURNS (
    URI VARCHAR(50),
    CLS VARCHAR(50),
    TITLE VARCHAR(50),
    GRP VARCHAR(50),
    MENUIDX INTEGER,
    OPTIONS VARCHAR(1024),
    PARAMS VARCHAR(1024),
    OUTS VARCHAR(1024),
    USEPERM INTEGER,
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50),
    ENT_EVIEW VARCHAR(100),
    ENT_VIEW_READONLY INTEGER,
    ENT_VIEW_PKEY VARCHAR(50),
    ENT_SQL_SELECT VARCHAR(1024),
    ENT_SQL_INSERT VARCHAR(1024),
    ENT_SQL_INSERTDEF VARCHAR(1024),
    ENT_SQL_UPDATE VARCHAR(1024),
    ENT_SQL_DELETE VARCHAR(1024),
    ENT_SQL_REFRESH VARCHAR(1024),
    UI_TITLE VARCHAR(250))
AS
begin
  select ui.uri, ui.cls, ui.title, ui.grp, ui.menuidx, ui.options,
         ui.params, ui.outs, ui.useperm, ui.pkg,
         ui.entityname, coalesce(ui.viewname, cls.viewname),
         ev.sql_select, ev.sql_insert, ev.sql_update, ev.sql_delete,
         ev.sql_refresh, ev.sql_insertdef,
         ev.readonly, ev.pkey
  from bfw_ui ui
       left join bfw_ui_cls cls on (cls.cls = ui.cls)
       left join bfw_ent_views ev on (ev.entityname = ui.entityname and ev.viewname = coalesce(ui.viewname, cls.viewname))
  where ui.uri = :uri_
  into :uri, :cls, :title, :grp, :menuidx, :options,
       :params, :outs, :useperm, :pkg,
       :ent, :ent_view,
       :ent_sql_select, :ent_sql_insert, :ent_sql_update, :ent_sql_delete,
       :ent_sql_refresh, :ent_sql_insertdef,
       :ent_view_readonly, :ent_view_pkey;

  ENT_EVIEW = ent || '.' || coalesce(:ent_view, '');

  UI_TITLE = 'UI: ' || title;

  suspend;
end^


CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_ITEM_U (
    URI VARCHAR(50),
    TITLE VARCHAR(50),
    GRP VARCHAR(50),
    MENUIDX INTEGER,
    OPTIONS VARCHAR(1024),
    PARAMS VARCHAR(1024),
    OUTS VARCHAR(1024),
    USEPERM INTEGER,
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50),
    ENT_VIEW_READONLY INTEGER,
    ENT_VIEW_PKEY VARCHAR(50),
    ENT_SQL_SELECT VARCHAR(1024),
    ENT_SQL_INSERT VARCHAR(1024),
    ENT_SQL_INSERTDEF VARCHAR(1024),
    ENT_SQL_UPDATE VARCHAR(1024),
    ENT_SQL_DELETE VARCHAR(1024),
    ENT_SQL_REFRESH VARCHAR(1024))
AS
begin
  update bfw_ui
  set title = :title,
      grp = :grp,
      menuidx = :menuidx,
      options = :options,
      params = :params,
      outs = :outs,
      useperm = :useperm,
      pkg = :pkg
  where uri = :uri;


  update bfw_ent_views ev
  set ev.sql_select = :ent_sql_select,
      ev.sql_insert = :ent_sql_insert,
      ev.sql_insertdef = :ent_sql_insertdef,
      ev.sql_update = :ent_sql_update,
      ev.sql_delete = :ent_sql_delete,
      ev.sql_refresh = :ent_sql_refresh,
      ev.pkey = :ent_view_pkey,
      ev.readonly = :ent_view_readonly
  where ev.entityname = :ent and ev.viewname = :ent_view;
end^


CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_NEW
RETURNS (
    URI VARCHAR(50),
    CLS VARCHAR(50),
    TITLE VARCHAR(50),
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50),
    ENT_EVIEW VARCHAR(100))
AS
begin

  suspend;
end^


CREATE OR ALTER PROCEDURE BFW_IDE_EV_UI_NEW_U (
    URI VARCHAR(50),
    CLS VARCHAR(50),
    TITLE VARCHAR(50),
    PKG VARCHAR(50),
    ENT VARCHAR(50),
    ENT_VIEW VARCHAR(50))
AS
begin
  ent = upper(ent);

  insert into bfw_ui(uri, cls, title, pkg, entityname, viewname)
  values(:uri, :cls, :title, :pkg, :ent, :ent_view);

  if (not exists(select * from bfw_ent_views where entityname = :ent and viewname = :ent_view)) then
  begin
    insert into bfw_ent_views(entityname, viewname)
    values(:ent, :ent_view);
  end
end^



SET TERM ; ^