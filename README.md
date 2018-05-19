# Running Vagrant
Assuming vagrant is installed.

## Further setup
```
# build
vagrant up

# move into machine
vagrant ssh

# activate python
source venvs/appname/bin/activate

# install requirements
pip install -r app/requirements.txt
```

## Import DB

```
# postgres console
psql postgres

# connect to DB
\connect appname_db

# import
\i app/dump

# exit
\q

```

## Block chain
```
mkdir -p /home/vagrant/app/etherium/data
# Set up your genisis block if you havent look at populus... its installed too!
geth --datadir="/home/vagrant/app/etherium/data" init /home/vagrant/app/etherium/genesis.json

# must have account before mining
geth --datadir="/home/vagrant/app/etherium/data/" --networkid 61575 --nodiscover console
personal.newAccount() => some_hash
```

## Interactive shell
```
geth attach /home/vagrant/app/etherium/data/geth.ipc
```
