ну этот диплом мы делаем для марии
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
psql -h localhost -d quantoriums -U postgres -f "masha_backup12.sql"