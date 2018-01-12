"""
Load the hobo files into the database

"""
from sqlalchemy import create_engine
import pandas as pd
import glob, os
from datetime import datetime as dt


def load_hobos(path):
    hobos = glob.glob(os.path.join(path, '*.txt'))
    print('Found %d Hobos' % len(hobos))
    for hobo in hobos:
        df = pd.read_csv(hobo, sep='\t', skiprows=1, usecols=[1,2,3,4])
        hobo_id = os.path.basename(hobo).split('.')[0]
        yield hobo_id, df


def dtime_index(df):
    f = lambda d,t: dt.strptime(d + ' ' + t, '%d-%m-%y %H:%M:%S')
    for i, row in df.iterrows():
        yield f(row[0], row[1])


def extract_hobo(df, oid):
    dt_idx = list(dtime_index(df))
    temp = pd.DataFrame({'value': df.iloc[:,2], 'date': dt_idx, 'variable_id': 9, 'id': oid}).dropna()
    inten = pd.DataFrame({'value': df.iloc[:,3], 'date': dt_idx, 'variable_id': 10, 'id': oid}).dropna()

    return temp, inten


def import_hobo(hobo, con, hobo_id):
    r = con.execute('select id from stations where hobo_id=%s and discipline_id<100' % hobo_id)
    oid = r.scalar()
    if oid is None:
        print('No entry found for HOBO ID %s.' % hobo_id)
        return
    else:
        print('HOBO ID %s ==> station id: %d' % (hobo_id, oid))
    temp, inten = extract_hobo(hobo, oid)
    try:
        temp.to_sql('data', con, if_exists='append', index=False)
    except Exception as e:
        print(str(e))
    try:
        inten.to_sql('data', con, if_exists='append', index=False)
    except Exception as e:
        print(str(e))
    print('Uploaded OID: %d.' % oid)


def upload(path, uri):
    engine = create_engine(uri)

    with engine.connect() as con:
        for hobo_id, hobo in load_hobos(path):
            import_hobo(hobo, con, hobo_id)

if __name__ == '__main__':
    # call like: >python import_hobo.py path_to_hobos uri_to_database
    import sys
    upload(sys.argv[1], sys.argv[2])
