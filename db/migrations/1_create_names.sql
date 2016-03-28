DROP TABLE IF EXISTS names;

CREATE TABLE names (
  id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  count INT NOT NULL,
  gender CHAR(1) NOT NULL,
  neighborhood VARCHAR(30) NOT NULL,
  UNIQUE(name, gender, neighborhood)
);
