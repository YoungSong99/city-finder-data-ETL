-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS CityFinder.SchoolScores;
DROP TABLE IF EXISTS CityFinder.CrimeRates;
DROP TABLE IF EXISTS CityFinder.AppreciationRates;
DROP TABLE IF EXISTS CityFinder.Cities;

-- Create the Cities table
CREATE TABLE CityFinder.Cities (
    city_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    state VARCHAR(50),
    longitude FLOAT,
    latitude FLOAT,
    PRIMARY KEY (city_id),
    UNIQUE (name)
);

-- Create the SchoolScores table with a foreign key reference to the Cities table
CREATE TABLE CityFinder.SchoolScores (
    school_score_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    score_compared_to_il INT,
    score_compared_to_us INT,
    city_name VARCHAR(200) NOT NULL,
    FOREIGN KEY (city_name) REFERENCES Cities(name)
);

-- Create the CrimeRates table with a foreign key reference to the Cities table
CREATE TABLE CityFinder.CrimeRates (
    crime_rate_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    crime_index FLOAT,
    violent_crime_rate FLOAT,
    property_crime_rate FLOAT,
    city_name VARCHAR(200) NOT NULL,
    FOREIGN KEY (city_name) REFERENCES Cities(name)
);


-- Create the AppreciationRates table with a foreign key reference to the Cities table
CREATE TABLE CityFinder.AppreciationRates (
    appreciation_rate_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    latest_quarter FLOAT,
    last_12_months FLOAT,
    last_2_years FLOAT,
    last_5_years FLOAT,
    last_10_years FLOAT,
    since_2000 FLOAT,
    city_name VARCHAR(200) NOT NULL,
    FOREIGN KEY (city_name) REFERENCES Cities(name));



SELECT 
    c.name AS city_name,
    c.state,
    ss.score_compared_to_il,
    ss.score_compared_to_us,
    cr.crime_index,
    cr.violent_crime_rate,
    cr.property_crime_rate,
    ar.latest_quarter,
    ar.last_12_months,
    ar.last_2_years,
    ar.last_5_years,
    ar.last_10_years,
    ar.since_2000
FROM 
    CityFinder.Cities c
JOIN 
    CityFinder.SchoolScores ss ON c.name = ss.city_name
JOIN 
    CityFinder.CrimeRates cr ON c.name = cr.city_name
JOIN 
    CityFinder.AppreciationRates ar ON c.name = ar.city_name
ORDER BY 
    ss.score_compared_to_il DESC, 
    cr.crime_index ASC, 
    ar.last_12_months DESC;

