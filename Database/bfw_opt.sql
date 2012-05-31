/******************************************************************************/
/***          Generated by IBExpert 2012.03.13 31.05.2012 17:41:15          ***/
/******************************************************************************/

SET NAMES WIN1251;

CONNECT '' USER 'SYSDBA';

INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.ENTITY.ItemDef', 'IEntityItemDef', '-', NULL, '-', NULL, 0, 'DefaultURI=views.%s.Item;EViewURI=ItemURI;EViewURIField=URI', 'ID', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.ENTITY.DetailDef', 'IEntityItemDef', '-', NULL, '-', NULL, 0, 'DefaultURI=views.%s.Detail;EViewURI=DetailURI;EViewURIField=URI', 'ID', NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.ENTITY.NewDef', 'IEntityNewDef', '-', NULL, '-', NULL, 0, 'DefaultURI=views.%s.New', NULL, NULL, 0, NULL);
INSERT INTO BFW_UI (URI, CLS, ENTITYNAME, VIEWNAME, TITLE, GRP, MENUIDX, OPTIONS, PARAMS, OUTS, USEPERM, PKG) VALUES ('views.ENTITY.DetailNewDef', 'IEntityNewDef', '-', '', '-', NULL, 0, 'DefaultURI=views.%s.DetailNew', 'HID', NULL, 0, NULL);

COMMIT WORK;

INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityListView', 'commands.view.open', '�������', 0, NULL, 0, 'views.ENTITY.ItemDef', 'ID=ITEM_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityTreeListView', 'commands.view.open', '�������', 0, NULL, 0, 'views.ENTITY.ItemDef', 'ID=ITEM_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityJournalView', 'commands.view.open', '�������', 0, NULL, 0, 'views.ENTITY.ItemDef', 'ID=ITEM_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityCollectView', 'commands.view.open', '�������', 0, NULL, 0, 'views.ENTITY.DetailDef', 'ID=ITEM_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityComplexView', 'commands.view.detail.open', '������� ������', 0, NULL, 0, 'views.ENTITY.DetailDef', 'ID=DETAIL_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityListView', 'commands.view.new', '��������', 0, NULL, 0, 'views.ENTITY.NewDef', NULL, NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityTreeListView', 'commands.view.new', '��������', 0, NULL, 0, 'views.ENTITY.NewDef', 'PARENT_ID=EV.PARENT_ID', NULL, NULL, NULL, NULL);
INSERT INTO BFW_UI_CMD (URI, CMD, CAPTION, IDX, GRP, DEF, HANDLER, PARAMS, OUTS, OPTIONS, CONDITION, CONDITION_PARAMS) VALUES ('IEntityJournalView', 'commands.view.new', '��������', 0, NULL, 0, 'views.ENTITY.NewDef', NULL, NULL, NULL, NULL, NULL);

COMMIT WORK;

