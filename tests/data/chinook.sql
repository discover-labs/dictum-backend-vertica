--
-- Vertica database dump
-- Dumped from Postgres and manually edited to support Vertica
-- Mostly removed postgres-specific settings and sequences.
--

CREATE TABLE public.albums (
    albumid bigint NOT NULL,
    title varchar,
    artistid bigint
);


ALTER TABLE public.albums OWNER TO chinook;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.artists (
    artistid bigint NOT NULL,
    name varchar
);


ALTER TABLE public.artists OWNER TO chinook;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.customers (
    customerid bigint NOT NULL,
    firstname varchar,
    lastname varchar,
    company varchar,
    address varchar,
    city varchar,
    state varchar,
    country varchar,
    postalcode varchar,
    phone varchar,
    fax varchar,
    email varchar,
    supportrepid bigint
);


ALTER TABLE public.customers OWNER TO chinook;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.employees (
    employeeid bigint NOT NULL,
    lastname varchar,
    firstname varchar,
    title varchar,
    reportsto bigint,
    birthdate timestamp with time zone,
    hiredate timestamp with time zone,
    address varchar,
    city varchar,
    state varchar,
    country varchar,
    postalcode varchar,
    phone varchar,
    fax varchar,
    email varchar
);


ALTER TABLE public.employees OWNER TO chinook;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.genres (
    genreid bigint NOT NULL,
    name varchar
);


ALTER TABLE public.genres OWNER TO chinook;


--
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.invoice_items (
    invoicelineid bigint NOT NULL,
    invoiceid bigint,
    trackid bigint,
    unitprice numeric(10,2),
    quantity bigint
);


ALTER TABLE public.invoice_items OWNER TO chinook;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.invoices (
    invoiceid bigint NOT NULL,
    customerid bigint,
    invoicedate timestamp with time zone,
    billingaddress varchar,
    billingcity varchar,
    billingstate varchar,
    billingcountry varchar,
    billingpostalcode varchar,
    total numeric(10,2)
);


ALTER TABLE public.invoices OWNER TO chinook;


--
-- Name: media_types; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.media_types (
    mediatypeid bigint NOT NULL,
    name varchar
);


ALTER TABLE public.media_types OWNER TO chinook;


--
-- Name: playlist_track; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.playlist_track (
    playlistid bigint NOT NULL,
    trackid bigint NOT NULL
);


ALTER TABLE public.playlist_track OWNER TO chinook;

--
-- Name: playlists; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.playlists (
    playlistid bigint NOT NULL,
    name varchar
);


ALTER TABLE public.playlists OWNER TO chinook;

--
-- Name: tracks; Type: TABLE; Schema: public; Owner: chinook
--

CREATE TABLE public.tracks (
    trackid bigint NOT NULL,
    name varchar,
    albumid bigint,
    mediatypeid bigint,
    genreid bigint,
    composer varchar,
    milliseconds bigint,
    bytes bigint,
    unitprice numeric(10,2)
);


ALTER TABLE public.tracks OWNER TO chinook;


COPY public.albums (albumid, title, artistid) FROM '/home/dbadmin/data/albums.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.artists (artistid, name) FROM '/home/dbadmin/data/artists.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.customers (customerid, firstname, lastname, company, address, city, state, country, postalcode, phone, fax, email, supportrepid) FROM '/home/dbadmin/data/customers.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.employees (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode, phone, fax, email) FROM '/home/dbadmin/data/employees.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.genres (genreid, name) FROM '/home/dbadmin/data/genres.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.invoice_items (invoicelineid, invoiceid, trackid, unitprice, quantity) FROM '/home/dbadmin/data/invoice_items.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.invoices (invoiceid, customerid, invoicedate, billingaddress, billingcity, billingstate, billingcountry, billingpostalcode, total) FROM '/home/dbadmin/data/invoices.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.media_types (mediatypeid, name) FROM '/home/dbadmin/data/media_types.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.playlist_track (playlistid, trackid) FROM '/home/dbadmin/data/playlist_track.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.playlists (playlistid, name) FROM '/home/dbadmin/data/playlists.tsv' DELIMITER e'\t' ABORT ON ERROR;
COPY public.tracks (trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice) FROM '/home/dbadmin/data/tracks.tsv' DELIMITER e'\t' ABORT ON ERROR;
