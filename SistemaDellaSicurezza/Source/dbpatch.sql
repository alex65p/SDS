
alter table sc_objects add data date null;
update sc_objects set data="DATE";
alter table sc_objects drop column "DATE";


alter table sc_context add data date null;
update sc_context set data="DATE";
alter table sc_context drop column "DATE";

