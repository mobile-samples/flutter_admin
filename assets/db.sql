CREATE TABLE modules (
  moduleid varchar(40) PRIMARY KEY,
  modulename varchar(255) not null,
  status char(1) not null,
  path varchar(255),
  resourcekey varchar(255),
  icon varchar(255),
  sequence int not null,
  parent varchar(40),
  createdby varchar(40),
  createdat timestamp,
  updatedby varchar(40),
  updatedat timestamp
);

CREATE TABLE users (
  userid varchar(40) PRIMARY KEY,
  username varchar(255) not null,
  email varchar(255) not null,
  displayname varchar(255) not null,
  status char(1) not null,
  gender char(1),
  phone varchar(20),
  title varchar(10),
  position varchar(40),
  imageurl varchar(500),
  createdby varchar(40),
  createdat timestamp,
  updatedby varchar(40),
  updatedat timestamp,
  lastlogin timestamp
);

CREATE TABLE roles (
  roleid varchar(40) PRIMARY KEY,
  rolename varchar(255) not null,
  status char(1) not null,
  remark varchar(255),
  createdby varchar(40),
  createdat timestamp,
  updatedby varchar(40),
  updatedat timestamp
);
CREATE TABLE userroles (
  userid varchar(40) not null,
  roleid varchar(40) not null,
  PRIMARY KEY (userid, roleid)
);
CREATE TABLE rolemodules (
  roleid varchar(40) not null,
  moduleid varchar(40) not null,
  permissions int not null,
  PRIMARY KEY (roleid, moduleid)
);

CREATE TABLE auditlog (
  id varchar(255) PRIMARY KEY,
  resourcetype varchar(255),
  userid varchar(255),
  ip varchar(255),
  action varchar(255),
  timestamp timestamp,
  status varchar(255),
  remark varchar(255)
);
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('dashboard','Dashboard','A','/dashboard','dashboard','assignments',1,'');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('admin','Admin','A','/admin','admin','contacts',2,'');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('setup','Setup','A','/setup','setup','settings',3,'');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('report','Report','A','/report','report','pie_chart',4,'');

INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('user','User Management','A','/users','user','person',1,'admin');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('role','Role Management','A','/roles','role','credit_card',2,'admin');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('role_assignment','Role Management','A','/role-assignment','role_assignment','credit_card',3,'admin');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('audit_log','Audit Log','A','/audit-logs','audit_log','zoom_in',4,'admin');

INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('group','Group','A','/group','group','group',1,'setup');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('company','Company Profile','A','/companies','company','',2,'setup');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('product','Product Profile','A','/products','product','',3,'setup');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('fee','Fee Profile','A','/fees','fee','',4,'setup');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('merchant','Merchant Profile','A','/merchants','merchant','',5,'setup');

INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('activity_log','Activity Log','A','/activity-logs','activity_log','zoom_in',2,'report');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('operation_report','Operation Report','A','/operation-report','operation_report','chrome_reader_mode',2,'report');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('merchant_report','Merchant Report','A','/merchant-report','merchant_report','',3,'report');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('merchant_fee_report','Merchant Fee Report','A','/merchant-fee-report','merchant_fee_report','attach_money',4,'report');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('summary_report','Summary Report','A','/summary-report','summary_report','',5,'report');
INSERT INTO modules (moduleid,modulename,status,path,resourcekey,icon,sequence,parent) VALUES ('transaction_report','Transaction Report','A','/transaction-report','transaction_report','',6,'report');

INSERT INTO roles (roleid, rolename, status, remark) VALUES ('admin','Admin','A','Admin');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('call_center','Call Center','A','Call Center');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('it_support','IT Support','A','IT Support');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('operator','Operator Group','A','Operator Group');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('product_operator','Product Operator','A','Product Operator');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('product_owner','Product Owner','A','Product Owner');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('user_role_admin','User Role Admin','A','User Role Admin');
INSERT INTO roles (roleid, rolename, status, remark) VALUES ('user_role_operator','User Role Operator','A','User Role Operator');

INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00001','gareth.bale','gareth.bale@gmail.com','Gareth Bale','https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Liver-RM_%282%29_%28cropped%29.jpg/440px-Liver-RM_%282%29_%28cropped%29.jpg','A','M','0987654321','Mr','M');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00002','cristiano.ronaldo','cristiano.ronaldo@gmail.com','Cristiano Ronaldo','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cristiano_Ronaldo_2018.jpg/400px-Cristiano_Ronaldo_2018.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00003','james.rodriguez','james.rodriguez@gmail.com','James Rodríguez','https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/James_Rodriguez_2018.jpg/440px-James_Rodriguez_2018.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00004','zinedine.zidane','zinedine.zidane@gmail.com','Zinedine Zidane','https://upload.wikimedia.org/wikipedia/commons/f/f3/Zinedine_Zidane_by_Tasnim_03.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00005','kaka','kaka@gmail.com','Kaká','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Kak%C3%A1_visited_Stadium_St._Petersburg.jpg/500px-Kak%C3%A1_visited_Stadium_St._Petersburg.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00006','luis.figo','luis.figo@gmail.com','Luís Figo','https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/UEFA_TT_7209.jpg/440px-UEFA_TT_7209.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00007','ronaldo','ronaldo@gmail.com','Ronaldo','https://upload.wikimedia.org/wikipedia/commons/c/c8/Real_Valladolid-Valencia_CF%2C_2019-05-18_%2890%29_%28cropped%29.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00008','thibaut.courtois','thibaut.courtois@gmail.com','Thibaut Courtois','https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Courtois_2018_%28cropped%29.jpg/440px-Courtois_2018_%28cropped%29.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00009','luka.modric','luka.modric@gmail.com','Luka Modrić','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/ISL-HRV_%287%29.jpg/440px-ISL-HRV_%287%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00010','xabi.alonso','xabi.alonso@gmail.com','Xabi Alonso','https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Xabi_Alonso_Training_2017-03_FC_Bayern_Muenchen-3_%28cropped%29.jpg/440px-Xabi_Alonso_Training_2017-03_FC_Bayern_Muenchen-3_%28cropped%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00011','karim.benzema','karim.benzema@gmail.com','Karim Benzema','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Karim_Benzema_2018.jpg/440px-Karim_Benzema_2018.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00012','marc-andre.ter.stegen','marc-andre.ter.stegen@gmail.com','Marc-André ter Stegen','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Marc-Andr%C3%A9_ter_Stegen.jpg/500px-Marc-Andr%C3%A9_ter_Stegen.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00013','sergino.dest','sergino.dest@gmail.com','Sergiño Dest','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Sergino_Dest.jpg/440px-Sergino_Dest.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00014','gerard.pique','gerard.pique@gmail.com','Gerard Piqué','https://upload.wikimedia.org/wikipedia/commons/4/4e/Gerard_Piqu%C3%A9_2018.jpg','A','M','0987654321','Mr','M');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00015','ronald.araujo','ronald.araujo@gmail.com@gmail.com','Ronald Araújo','https://pbs.twimg.com/media/EtnqxaEU0AAc6A6.jpg','A','M','0987654321','Mr','M');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00016','sergio.busquets','sergio.busquets@gmail.com@gmail.com','Sergio Busquets','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Sergio_Busquets_2018.jpg/440px-Sergio_Busquets_2018.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00017','antoine.griezmann','antoine.griezmann@gmail.com@gmail.com','Antoine Griezmann','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Antoine_Griezmann_in_2018_%28cropped%29.jpg/440px-Antoine_Griezmann_in_2018_%28cropped%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00018','miralem.pjanic','miralem.pjanic@gmail.com@gmail.com','Miralem Pjanić','https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/20150331_2025_AUT_BIH_2130_Miralem_Pjani%C4%87.jpg/440px-20150331_2025_AUT_BIH_2130_Miralem_Pjani%C4%87.jpg','A','M','0987654321','Mrs','M');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00019','martin.braithwaite','martin.braithwaite@gmail.com@gmail.com','Martin Braithwaite','https://pbs.twimg.com/profile_images/1231549032943800320/WR769kKG_400x400.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00020','ousmane.dembele','ousmane.dembele@gmail.com@gmail.com','Ousmane Dembélé','https://upload.wikimedia.org/wikipedia/commons/7/77/Ousmane_Demb%C3%A9l%C3%A9_2018.jpg','A','M','0987654321','Ms','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00021','riqui.puig','riqui.puig@gmail.com@gmail.com','Riqui Puig','https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Bar%C3%A7a_Napoli_12_%28cropped%29.jpg/440px-Bar%C3%A7a_Napoli_12_%28cropped%29.jpg','A','M','0987654321','Ms','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00022','philip.coutinho','philip.coutinho@gmail.com@gmail.com','Philip Coutinho','https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Norberto_Murara_Neto_2019.jpg/440px-Norberto_Murara_Neto_2019.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00023','victor.lindelof','victor.lindelof@gmail.com@gmail.com','Victor Lindelöf','https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/CSKA-MU_2017_%286%29.jpg/440px-CSKA-MU_2017_%286%29.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00024','eric.bailly','eric.bailly@gmail.com@gmail.com','Eric Bailly','https://upload.wikimedia.org/wikipedia/commons/c/cf/Eric_Bailly_-_ManUtd.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00025','phil.jones','phil.jones@gmail.com@gmail.com','Phil Jones','https://upload.wikimedia.org/wikipedia/commons/f/fa/Phil_Jones_2018-06-28_1.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00026','harry.maguire','harry.maguire@gmail.com@gmail.com','Harry Maguire','https://upload.wikimedia.org/wikipedia/commons/b/be/Harry_Maguire_2018-07-11_1.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00027','paul.pogba','paul.pogba@gmail.com@gmail.com','Paul Pogba','https://upload.wikimedia.org/wikipedia/commons/b/be/Harry_Maguire_2018-07-11_1.jpg','I','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00028','edinson.cavani','edinson.cavani@gmail.com@gmail.com','Edinson Cavani','https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Edinson_Cavani_2018.jpg/440px-Edinson_Cavani_2018.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00029','juan.mata','juan.mata@gmail.com@gmail.com','Juan Mata','https://upload.wikimedia.org/wikipedia/commons/7/70/Ukr-Spain2015_%286%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00030','anthony.martial','anthony.martial@gmail.com@gmail.com','Anthony Martial','https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Anthony_Martial_27_September_2017_cropped.jpg/440px-Anthony_Martial_27_September_2017_cropped.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00031','marcus.rashford','marcus.rashford@gmail.com@gmail.com','Marcus Rashford','https://upload.wikimedia.org/wikipedia/commons/5/5e/Press_Tren_CSKA_-_MU_%283%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00032','mason.greenwood','mason.greenwood@gmail.com@gmail.com','Mason Greenwood','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Mason_Greenwood.jpeg/440px-Mason_Greenwood.jpeg','A','M','0987654321','Ms','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00033','lee.grant','lee.grant@gmail.com@gmail.com','Lee Grant','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/LeeGrant09.jpg/400px-LeeGrant09.jpg','A','M','0987654321','Ms','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00034','jesse.lingard','jesse.lingard@gmail.com@gmail.com','Jesse Lingard','https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Jesse_Lingard_2018-06-13_1.jpg/440px-Jesse_Lingard_2018-06-13_1.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00035','keylor.navas','keylor.navas@gmail.com@gmail.com','Keylor Navas','https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Liver-RM_%288%29_%28cropped%29.jpg/440px-Liver-RM_%288%29_%28cropped%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00036','achraf.hakimi','achraf.hakimi@gmail.com@gmail.com','Achraf Hakimi','https://upload.wikimedia.org/wikipedia/commons/9/91/Iran-Morocco_by_soccer.ru_14_%28Achraf_Hakimi%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00037','presnel.kimpembe','presnel.kimpembe@gmail.com@gmail.com','Presnel Kimpembe','https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Presnel_Kimpembe.jpg/400px-Presnel_Kimpembe.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00038','sergio.ramos','sergio.ramos@gmail.com@gmail.com','Sergio Ramos','https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/FC_RB_Salzburg_versus_Real_Madrid_%28Testspiel%2C_7._August_2019%29_09.jpg/440px-FC_RB_Salzburg_versus_Real_Madrid_%28Testspiel%2C_7._August_2019%29_09.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00039','marquinhos','marquinhos@gmail.com@gmail.com','Marquinhos','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Brasil_conquista_primeiro_ouro_ol%C3%ADmpico_nos_penaltis_1039278-20082016-_mg_4916_%28cropped%29.jpg/440px-Brasil_conquista_primeiro_ouro_ol%C3%ADmpico_nos_penaltis_1039278-20082016-_mg_4916_%28cropped%29.jpg','A','M','0987654321','Mr','E');
INSERT INTO users (userid,username,email,displayname,imageurl,status,gender,phone,title,position) VALUES ('00040','marco.verratti','marco.verratti@gmail.com@gmail.com','Marco Verratti','https://upload.wikimedia.org/wikipedia/commons/d/d0/Kiev-PSG_%289%29.jpg','A','M','0987654321','Mr','E');

INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','admin',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','role',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','user',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','role_assignment',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','audit_log',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','setup',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_admin','group',7);

INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','admin',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','role',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','user',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','role_assignment',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','audit_log',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','setup',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('user_role_operator','group',3);

INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','dashboard',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','admin',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','setup',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','audit_log',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','activity_log',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','operation_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','merchant_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','merchant_fee_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','summary_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','transaction_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','group',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','company',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','product',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','fee',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','merchant',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','user',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','role',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('admin','role_assignment',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','dashboard',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','admin',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','setup',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','audit_log',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','activity_log',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','operation_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','merchant_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','merchant_fee_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','summary_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','transaction_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','group',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','company',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','product',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','fee',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','merchant',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','user',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','role',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('it_support','role_assignment',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','dashboard',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','admin',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','setup',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','operation_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','merchant_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','merchant_fee_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','summary_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','transaction_report',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','group',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','company',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','product',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','fee',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_owner','merchant',7);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','dashboard',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','admin',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','setup',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','operation_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','merchant_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','merchant_fee_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','summary_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','transaction_report',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','group',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','company',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','product',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','fee',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('product_operator','merchant',3);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','dashboard',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','admin',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','setup',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','report',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','audit_log',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','activity_log',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','operation_report',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','merchant_report',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','merchant_fee_report',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','summary_report',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','transaction_report',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','group',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','company',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','product',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','fee',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','merchant',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','user',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','role',1);
INSERT INTO rolemodules(roleid,moduleid,permissions) VALUES ('call_center','role_assignment',1);

INSERT INTO userroles(userid, roleid) VALUES ('00001','admin');
INSERT INTO userroles(userid, roleid) VALUES ('00002','user_role_admin');
INSERT INTO userroles(userid, roleid) VALUES ('00003','admin');
INSERT INTO userroles(userid, roleid) VALUES ('00004','admin');
INSERT INTO userroles(userid, roleid) VALUES ('00005','it_support');
INSERT INTO userroles(userid, roleid) VALUES ('00006','product_owner');
INSERT INTO userroles(userid, roleid) VALUES ('00007','admin');
INSERT INTO userroles(userid, roleid) VALUES ('00008','call_center');
INSERT INTO userroles(userid, roleid) VALUES ('00009','it_support');
INSERT INTO userroles(userid, roleid) VALUES ('00010','call_center');
INSERT INTO userroles(userid, roleid) VALUES ('00011','it_support');
INSERT INTO userroles(userid, roleid) VALUES ('00011','product_owner');
INSERT INTO userroles(userid, roleid) VALUES ('00012','call_center');
INSERT INTO userroles(userid, roleid) VALUES ('00012','it_support');
INSERT INTO userroles(userid, roleid) VALUES ('00012','user_role_admin');
/*
ALTER TABLE userroles ADD FOREIGN KEY (userid) REFERENCES users (userid);
ALTER TABLE userroles ADD FOREIGN KEY (roleid) REFERENCES roles (roleid);

ALTER TABLE modules ADD FOREIGN KEY (parent) REFERENCES modules (moduleid);

ALTER TABLE rolemodules ADD FOREIGN KEY (roleid) REFERENCES roles (roleid);
ALTER TABLE rolemodules ADD FOREIGN KEY (moduleid) REFERENCES modules (moduleid);
*/