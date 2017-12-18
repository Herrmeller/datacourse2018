"""
This short script will synchronize the Googele spreadsheed with the postgres database.

You have to fill in the connection information and the spreachsheet link.
"""
from sqlalchemy import create_engine
import pandas as pd
import numpy as np

def get_spreadsheed(url, **kwargs):
    return pd.read_csv(url, **kwargs)


def update(url, uri, **kwargs):
    df = get_spreadsheed(url, **kwargs)
    engine = create_engine(uri)
    errors = 0

    with engine.connect() as con:
        for i, row in df.iterrows():
            sql = """
update stations set name='%s', 
  geometry=%s,
  description=%s, discipline_id=%s, hobo_id=%s
where id=%d
""" % (str(row['first_name'] + ' ' + row['family_name']),
       "st_transform(st_geomfromewkt('SRID=4326;POINT (%.8f %.8f)'), 25832)" % (row['longitude'], row['latitude']) if not np.isnan(row['longitude']) else 'NULL',
       "'%s'" % row['short_description_hobo_location'] if isinstance(row['short_description_hobo_location'], str) else 'NULL',
       row['discipline'].replace('Environmental_Science', '2').replace('Hydrology', '3').replace('Lecturer', '99'),
       str(int(row['hobo_id'])) if not np.isnan(row['hobo_id']) else 'NULL', int(row['id']))
            print(sql)
            try:
                con.execute(sql)
            except Exception as e:
                errors += 1
                print('ERROR: %s\nskipping...' % str(e))
        print('--------------\n finished (%d errors)' % errors)

if __name__ == '__main__':
    # call like: >python synchronize_metafile.py url_to_spreadsheed uri_to_database
    import sys
    update(sys.argv[1], sys.argv[2])
