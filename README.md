# Running Vagrant
Assuming vagrant is installed. This is a python based environment to dev. on ethereum block chain.

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
mkdir -p /home/vagrant/app/ethereum/data
# Set up your genisis block if you havent look at populus... its installed too!
geth --datadir="/home/vagrant/app/ethereum/data" init /home/vagrant/app/ethereum/genesis.json

# must have account before mining
geth --datadir="/home/vagrant/app/ethereum/data/" --networkid 61575 --nodiscover console
personal.newAccount() => some_hash
```

## Interactive shell
```
geth attach /home/vagrant/app/ethereum/data/geth.ipc
```
