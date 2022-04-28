-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.card_holder
(
    card_holder_id integer NOT NULL,
    full_name character varying NOT NULL,
    PRIMARY KEY (card_holder_id)
);

CREATE TABLE IF NOT EXISTS public.credit_card
(
    card_number character varying(20) NOT NULL,
    card_holder_id integer NOT NULL,
    PRIMARY KEY (card_number)
);

CREATE TABLE IF NOT EXISTS public.merchant
(
    merchant_id integer NOT NULL,
    merchant_name character varying(30) NOT NULL,
    merchant_category_id integer NOT NULL,
    PRIMARY KEY (merchant_id)
);

CREATE TABLE IF NOT EXISTS public.merchant_category
(
    merchant_category_id integer NOT NULL,
    category character varying(30) NOT NULL,
    PRIMARY KEY (merchant_category_id)
);

CREATE TABLE IF NOT EXISTS public.transaction
(
    transaction_id integer NOT NULL,
    transaction_date timestamp without time zone NOT NULL,
    amount numeric(20, 2) NOT NULL,
    card_number character varying(30) NOT NULL,
    merchant_id integer NOT NULL,
    PRIMARY KEY (transaction_id)
);

ALTER TABLE IF EXISTS public.credit_card
    ADD CONSTRAINT fk_card_holder_id FOREIGN KEY (card_holder_id)
    REFERENCES public.card_holder (card_holder_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.merchant
    ADD CONSTRAINT fk_merchant_category_id FOREIGN KEY (merchant_category_id)
    REFERENCES public.merchant_category (merchant_category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.transaction
    ADD CONSTRAINT fk_merchant_id FOREIGN KEY (merchant_id)
    REFERENCES public.merchant (merchant_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.transaction
    ADD CONSTRAINT fk_credit_card FOREIGN KEY (card_number)
    REFERENCES public.credit_card (card_number) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;