db_name="beergarden"

# terminate DB connections, re-create the DB empty.
echo "
UPDATE pg_database SET datallowconn = 'false' WHERE datname = '${db_name}';
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '${db_name}';
DROP DATABASE IF EXISTS ${db_name};
CREATE DATABASE ${db_name};
" | psql -U postgres

# Load example data.
echo "
CREATE EXTENSION \"pgcrypto\";
    CREATE TABLE beers (
        uuid UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
        name text NOT NULL,
        description text,
        size text,
        percent FLOAT8 NOT NULL DEFAULT 0.0);

    INSERT INTO beers (name, description, percent, size) VALUES
                      ('Hofbrau Original', ' Classic from Munich.', 5.1, '500ml'),
                      ('Hofbrau Dunkel', ' Classic from Munich in Dark.', 5.1, '500ml'),
                      ('Berliner Pilsner', 'Water, Barley Malt and Hop Extract', 5.0, '330ml'),
                      ('Erdinger Weissbier', 'The ultimate premium wheat beer. Traditionally matured in the bottle – like champagne.', 5.3, '500ml'),
                      ('Augustiner Helles', 'A cult classic and the only major Munich brewer to never use advertising to sell its beer. ', 5.2, '500ml'),
                      ('Berliner Kindle Weisse', 'Cloudy sour beer from Northern Germany.', 3.0, '500ml'),
                      ('Krombacher', 'Krombacher is Germanys bestselling premium Pils it is still family-owned and since 1803 has only brewed at source.', 4.8, '500ml'),
                      ('Flensburger Pilsener', 'Fresh from Germanys most northern brewery, Flensburger is a favourite of domestic and international markets, not least because of its easily recognisable 330ml stubby flip top bottle.', 4.8, '330ml'),
                      ('Schneider Weisse', 'A real taste of Germany is just on your doorstep. Schneider Weisse Tap 7 Original is brewed according to the original recipe that Georg I. Schneider created.', 5.4, '500ml'),
                      ('Maisel Weisse', 'Traditional weissbier made according to the old Bavarian style with the unmistakable character of the fine cellar yeast.', 5.4, '500ml');
" | psql -U postgres ${db_name}
