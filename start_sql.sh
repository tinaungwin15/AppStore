# Construct the URI from the .env
DB_HOST= 'ec2-3-223-213-207.compute-1.amazonaws.com'
DB_NAME= 'd4bjk3v2hueagk'
DB_USER= 'lurpmtlsysyvgr'
DB_PORT= '5432'
DB_PASSWORD= '52f3e45e90bcb762fafa0498e22e149bf9a9e768c39d27fdcec84183ed1e79a'

while IFS= read -r line
do
  if [[ $line == DB_HOST* ]]
  then
    DB_HOST=$(cut -d "=" -f2- <<< $line | tr -d \')
  elif [[ $line == DB_NAME* ]]
  then
    DB_NAME=$(cut -d "=" -f2- <<< $line | tr -d \' )
  elif [[ $line == DB_USER* ]]
  then
    DB_USER=$(cut -d "=" -f2- <<< $line | tr -d \' )
  elif [[ $line == DB_PORT* ]]
  then
    DB_PORT=$(cut -d "=" -f2- <<< $line | tr -d \')
  elif [[ $line == DB_PASSWORD* ]]
  then
    DB_PASSWORD=$(cut -d "=" -f2- <<< $line | tr -d \')
  fi
done < ".env"

URI="postgres://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"

# Run the scripts to insert data.
psql ${URI}
