CREATE extension IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS city (
    fid serial PRIMARY KEY,
    name varchar(100) not null,
    county varchar(100) not null,
    population int,
    geom GEOMETRY(Polygon, 4326) not null
);

CREATE TABLE IF NOT EXISTS river_banks (
    fid serial PRIMARY KEY,
    name varchar(100) not null,
    geometry GEOMETRY(linestring, 4326) not null,
	description text,
    fid_city int not null,
	FOREIGN KEY (fid_city) REFERENCES city(fid)
);

CREATE TABLE IF NOT EXISTS type_landuse (
    id serial PRIMARY KEY,
    type varchar(50) not null,
    building_nr int
);

CREATE TABLE IF NOT EXISTS landuse (
    id serial PRIMARY KEY,
	name varchar (50) not null,
    geometry GEOMETRY(polygon, 4326) not null,
	owner varchar (100),
    fid_river_banks int not null,
    id_type_landuse int not null,
    FOREIGN KEY (fid_river_banks) REFERENCES river_banks(fid),
    FOREIGN KEY (id_type_landuse) REFERENCES type_landuse(id)
);


CREATE TABLE IF NOT EXISTS tree_species (
    id serial PRIMARY KEY,
    species varchar(100) not null,
	latin_name varchar(100),
	healthy boolean
);

CREATE TABLE IF NOT EXISTS trees (
    fid serial PRIMARY KEY,
	height float not null,
    geometry GEOMETRY(point, 4326) not null,
	circumference float,
    fid_river_banks int not null,
    id_tree_species int not null,
    FOREIGN KEY (fid_river_banks) REFERENCES river_banks(fid),
    FOREIGN KEY (id_tree_species) REFERENCES tree_species(id)
);


CREATE TABLE IF NOT EXISTS facilities (
    fid serial PRIMARY KEY,
	name varchar(100),
    geom GEOMETRY(Polygon, 4326),
    fid_river_banks int not null,
    FOREIGN KEY (fid_river_banks) REFERENCES river_banks(fid)
);

CREATE TABLE IF NOT EXISTS type_facility (
    id serial PRIMARY KEY,
    type varchar(50) not null,
    description varchar(100)
);

CREATE TABLE IF NOT EXISTS facilities_type_facility (
    id serial PRIMARY KEY,
    fid_facilities int not null,
    id_type_facility int not null,
    FOREIGN KEY (fid_facilities) REFERENCES facilities(fid),
    FOREIGN KEY (id_type_facility) REFERENCES type_facility(id)
);

CREATE TABLE IF NOT EXISTS type_street (
    id serial PRIMARY KEY,
    type varchar(50) not null,
    description varchar(100)
);

CREATE TABLE IF NOT EXISTS street_network (
    fid serial PRIMARY KEY,
    name varchar(100),
    geom GEOMETRY(linestring, 4326),
    fid_river_banks int not null,
    id_type_street int not null,
    FOREIGN KEY (fid_river_banks) REFERENCES river_banks(fid),
    FOREIGN KEY (id_type_street) REFERENCES type_street(id)
);

CREATE TABLE IF NOT EXISTS type_bridge (
    id serial PRIMARY KEY,
    type varchar(50) not null
);

CREATE TABLE IF NOT EXISTS status_bridge (
    id serial PRIMARY KEY,
    status varchar(50) not null
);

CREATE TABLE IF NOT EXISTS bridge (
    fid serial PRIMARY KEY,
    name varchar(50),
    geom GEOMETRY(linestring, 4326),
    fid_river_banks int not null,
    id_type_bridge int not null,
    id_status_bridge int not null,
    FOREIGN KEY (fid_river_banks) REFERENCES river_banks(fid),
    FOREIGN KEY (id_type_bridge) REFERENCES type_bridge(id),
    FOREIGN KEY (id_status_bridge) REFERENCES status_bridge(id)
);

CREATE TABLE IF NOT EXISTS benches (
    fid serial PRIMARY KEY,
    places int not null,
	backrest boolean,
    geom GEOMETRY(point, 4326),
    fid_river_banks int not null,
    FOREIGN KEY (fid_river_banks) REFERENCES river_banks(fid)
);

ALTER TABLE tree_species
DROP COLUMN healthy;

ALTER TABLE type_landuse
DROP COLUMN building_nr;





