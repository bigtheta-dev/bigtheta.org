# Maven

Системы сборки
1. управление зависимостями
2. автоматицация сборки
3. версионирование

---
## Функциональность
* repeatable builds
* local repository
* dependency management
* build automation
* test automation
* deploy automation

---
Описание артефакта
* groupId
* artifactId
* version
* packaging

## Жизненный цикл
* clean
delete target directory and any generated resources
* compile 
Compiles all source code, generate any files, copies resources to our class directory
* package
runs the compile command first, runs any tests, package app based to it packaging type 
* install
runs package copy artifact to local repository
* deploy
runs install copy artifact to corporate repo

---
# Scope
1. compile
2. provided
3. runtime
4. test
5. system
6. import
---

![Image of Yaktocat](yaktocat.png)
## Концепции
1. Multimodule project
2. Reactor
3. BOM

# Build tool Java vs JavaScript vs Go





# Nexus setup
Requirement min **4Gb** memory

Environment: 
	Nexus 3.10.0-04 
	Ubuntu 16-04

## Installation
1. Download and isntall jre
    - `sudo apt-get update`
    - `sudo apt-get install default-jre`
2. Download nexus from https://help.sonatype.com/repomanager3/download
    - `wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz`
3. Unpack it to /opt folter
    - `sudo tar vxzf latest-unix.tar.gz -C /opt/`
4. Start nexus
    - `sudo /opt/nexus/.../bin/nexus start`

---

## Setup

> Documentation http://books.sonatype.com/nexus-book/3.0/reference/maven.html

### proxy repo

1. add to *settings.xml*

```xml
<settings>
  <mirrors>
    <mirror>
      <!--This sends everything else to /public -->
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://localhost:8081/repository/maven-public/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <!--Enable snapshots for the built in central repo to direct -->
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
      </repositories>
     <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
  <activeProfiles>
    <!--make the profile active all the time -->
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
</settings>
```

### private repo

add to project pom


```xml
<distributionManagement>
    <repository>
      <id>nexus</id>
      <name>Releases</name>
      <url>http://localhost:8081/repository/maven-releases</url>
    </repository>
    <snapshotRepository>
      <id>nexus</id>
      <name>Snapshot</name>
      <url>http://localhost:8081/repository/maven-snapshots</url>
    </snapshotRepository>
</distributionManagement>
```

add to settings.xml

```xml
<servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>
```
---
# Bitbucket setup

![](https://upload.wikimedia.org/wikipedia/en/thumb/d/df/BitBucket_SVG_Logo.svg/250px-BitBucket_SVG_Logo.svg.png)

port 7990

## Setup Postgres
Bitbucket 5.9 + Postgres 10

Documentation https://confluence.atlassian.com/bitbucketserver/connecting-bitbucket-server-to-postgresql-776640389.html

Requirement min **4Gb** memory

1. install postgres 10

sudo add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -

sudo apt-get update

sudo apt-get install postgresql-10

### if problems with locale
export LANGUAGE="en_US.UTF-8"
sudo -i
echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

2. create db and user

sudo -iu postgres
psql
CREATE ROLE bitbucketuser WITH LOGIN PASSWORD 'jellyfish' VALID UNTIL 'infinity';
CREATE DATABASE bitbucket WITH ENCODING='UTF8' OWNER=bitbucketuser CONNECTION LIMIT=-1; 

3. Download and install bitbucket

wget https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-5.9.1-x64.bin
chmod +x atlassian-bitbucket-5.9.1-x64.bin
sudo ./atlassian-bitbucket-5.9.1-x64.bin

4. Bitbucket available on 7990

---

# Confluence setup

![](https://en.wikipedia.org/wiki/File:Atlassian_Confluence_Logo.sv://upload.wikimedia.org/wikipedia/en/thumb/1/1b/Atlassian_Confluence_Logo.svg/200px-Atlassian_Confluence_Logo.svg.png)

port 8090

## Setup Postgres
Confluence 6.8 + Postgres 10
Documentation https://confluence.atlassian.com/doc/database-setup-for-postgresql-173244522.html

Running on **4Gb** memory

1. install postgres 10

sudo add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get install postgresql-10

### if problems with locale
export LANGUAGE="en_US.UTF-8"
sudo -i
echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

2. create db and user

sudo -iu postgres
psql
CREATE ROLE confluenceuser WITH LOGIN PASSWORD 'jellyfish' VALID UNTIL 'infinity';
CREATE DATABASE  confluence WITH ENCODING='UTF8' OWNER=confluenceuser CONNECTION LIMIT=-1; 

3. Download and install confluence

wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.8.1-x64.bin
chmod +x atlassian-confluence-6.8.1-x64.bin
sudo ./atlassian-confluence-6.8.1-x64.bin

**Confluence available on 8090**

---
---

# Teamcity setup

---

![](http://www.jetbrains.com/teamcity/)

---

port 8111

## Setup Postgres

---
![](https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Postgresql_elephant.svg/120px-Postgresql_elephant.svg.png) 

---

TeamCity 2017.2.3
Documentation https://confluence.jetbrains.com/display/TCD10/Installing+and+Configuring+the+TeamCity+Server 

Running on **4Gb** memory


1. install postgres 10

sudo add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get install postgresql-10

### install jdbc driver
sudo wget -P /root/.BuildServer/lib/jdbc https://jdbc.postgresql.org/download/postgresql-42.2.2.jar

### if problems with locale
export LANGUAGE="en_US.UTF-8"
sudo -i
echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale
echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale

2. create db and user

sudo -iu postgres
psql
CREATE ROLE teamcityuser WITH LOGIN PASSWORD 'jellyfish' VALID UNTIL 'infinity';
CREATE DATABASE  teamcity WITH ENCODING='UTF8' OWNER=teamcityuser CONNECTION LIMIT=-1; 

3. Download and install teamcity

sudo apt-get update
sudo apt-get install default-jre

wget https://download.jetbrains.com/teamcity/TeamCity-2017.2.3.tar.gz 
sudo tar vxzf TeamCity-2017.2.3.tar.gz -C /opt
sudo /opt/TeamCity/bin/teamcity-server.sh start

**TeamCity available on 8111**


