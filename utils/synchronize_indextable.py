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
update hobo_indices set name='%s', 
 discipline_id=%s, hobo_id=%s, influence='%s',
 tmean=%s, tmn=%s, tmx=%s, t90=%s, rel_na=%s
where id=%d
""" % (str(row['first_name'] + ' ' + row['family_name']),
       row['discipline'].replace('Environmental_Science', '2').replace('Hydrology', '3').replace('Lecturer', '99'),
       str(int(row['hobo_id'])) if not np.isnan(row['hobo_id']) else 'NULL',
       row['influence'] if isinstance(row['influence'], str) else 'NULL',
       float(row['Tmean']) if not np.isnan(float(row['Tmean'])) else 'NULL',
       float(row['Tmn']) if not np.isnan(float(row['Tmn'])) else 'NULL',
       float(row['Tmx']) if not np.isnan(float(row['Tmx'])) else 'NULL',
       float(row['T90']) if not np.isnan(float(row['T90'])) else 'NULL',
       float(row['rel_NA']) if not np.isnan(float(row['rel_NA'])) else 'NULL',
       int(row['id'])
       )
            print(sql)
            try:
                con.execute(sql)
            except Exception as e:
                errors += 1
                print('ERROR: %s\nskipping...' % str(e))


    print('--------------\n finished (%d errors)' % errors)


if __name__ == '__main__':
    # call like: >python synchronize_indextable.py url_to_spreadsheed uri_to_database
    import sys
    update(sys.argv[1], sys.argv[2])
