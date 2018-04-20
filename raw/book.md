
![](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Maven_logo.svg/220px-Maven_logo.svg.png)


**Maven** - система сборки проектов для Java. На данный момент это стандарт в языке. Альтернативой является Gradle, но Maven на данный момент более распространен.

**Maven** решает проблемы автоматизации сборки и уравления зависимостями как и другие инструменты этого класса, но имеет некоторые характерные черты:
* *Maven следует соглашениям по конфигурации*. Он знает какая у проекта должна быть структура,откуда брать файлы ресурсов и куда складывать созданные jar-файлы. И пользователям maven приходится соблюдать эти соглашения.
* *Maven декларативен*. Описание проекта в pom.xml представляется в декларативном виде. Декларативное представление отличается от императивного тем что оно отвечает плавным образом на вопрос что надо сделать чтобы собрать проект (императивное отвечает на вопрос как это сделать). 
* *Maven вводит понятие жизненного цикла*. Жизненный цикл представляет собой группу последовательных фаз, которые maven исполняет по порядку для достижения определенной цели. К фазам жизненного цикла могут быть прикреплены дополнительные действия при помощи плагинов.
 
---
## Project Object Model

Описание представляется в виде xml файла **pom.xml**, который помещается в корень проекта. Структура *pom.xml* выглядит следующим образом:

``` xml
<project ... >
	<modelVersion>4.0.0</modelVersion>

	<!-- Основная информация -->
	<groupId>...</groupId>
	<artifactId>...</artifactId>
	<version>...</version>
	<packaging>...</packaging>
	<dependencies>...</dependencies>
	<parent>...</parent>
	<dependencyManagement>...</dependencyManagement>
	<modules>...</modules>
	<properties>...</properties>

	<!-- Настройки сборки -->
	<build>...</build>
	<reporting>...</reporting>

	<!-- Метаданные проекта -->
	<name>...</name>
	<description>...</description>
	<url>...</url>
	<inceptionYear>...</inceptionYear>
	<licenses>...</licenses>
	<organization>...</organization>
	<developers>...</developers>
	<contributors>...</contributors>

	<!-- Окружение -->
	<issueManagement>...</issueManagement>
	<ciManagement>...</ciManagement>
	<mailingLists>...</mailingLists>
	<scm>...</scm>
	<prerequisites>...</prerequisites>
	<repositories>...</repositories>
	<pluginRepositories>...</pluginRepositories>
	<distributionManagement>...</distributionManagement>
	<profiles>...</profiles>
</project>
```

### Основная информация
Определяет артефакт, версии зависимостей, зависимости

### Настройки сборки
Настройка процесса сборки

### Метаданные проекта
Включает параметры специфические для отдельного проекта: имя, организацию, разработчиков и т.п.

### Окружение
Включает всю информацию про окружение: списки рассылки, репозитории ...

This includes a project’s name, the URL for a project, the sponsoring organization, and a list of
developers and contributors along with the license for a project.

Build settings

In this section, we customize the behavior of the default Maven build. We can change the location
of source and tests, we can add new plugins, we can attach plugin goals to the lifecycle, and we can
customize the site generation parameters.

Build environment

The build environment consists of profiles that can be activated for use in different environments.
For example, during development you may want to deploy to a development server, whereas in
production you want to deploy to a production server. The build environment customizes the 
settings for specific environments and is often supplemented by a custom settings.xml in ~/.m2.
This settings file is discussed in Chapter 5 and in the section Section 15.2.

POM relationships

A project rarely stands alone; it depends on other projects, inherits POM settings from parent projects, defines its own coordinates, and may include submodules.

### POM inheritance
#### Super POM
Все проекты собирающиеся с использованием Maven наследуются от общего родителя, который называется Super POM. В этом POM указаны ряд настроек, предустановленных для все maven проектов. В нем указаны такие настройки:
* в качестве репозитория для зависимостей и плагинов указан Maven Central (http://repo1.maven.org/maven2)
* в build секции указывается структура дерева директория по умолчанию
* в pluginManagement версии по умолчанию для часто использующихся плагинов

Для того чтобы собрать свой проект достаточно только указать минимальное описание, включающее в себя **groupId**, **artifactId**, **version**. Остальные данные будут взяты из **Super POM**. Так может выглядеть минимальный **POM**
``` xml
<project>
	<modelVersion>4.0.0</modelVersion>
	<groupId>org.bigtheta</groupId>
	<artifactId>mvn</artifactId>
	<version>1</version>
</project>
```
#### Effective POM
Для того чтобы работать с проектом **Maven** объединяет **Super POM** и **POM** конкретного проекта. В результате этого получается **Effective POM** с которым даллее происходит вся работа.

### The Basics
В процессе сборки maven собирает артефакт. Артефакт в mavenе описывается четырьмя свойствами:
* **groupId** - обычно описывает кем создан проект
* **artifactId** - обычно название проекта
* **version** - версия проекта
* **packaging** - вид поставки (jar, war, ear, zip, dir и т.п.)

### Build Settings
### Project Meta Data
### Environment

---
## Архетип
Для простоты создания новых проектов maven вводит такое поняти как архетип. Архетип - это заранне заготовленный шаблон проекта. При создании проекта из архетипа полность восстанавливается дерево директорий, устанавливаются необходимые зависимости. 

Процесс создания проекта из архетипа выглядит следующем образом:
```shell
mvn archetype:generate -DgroupId=org.bigtheta -DartifactId=mvn
``` 
либо можно создать проект в интерактивном режиме
```shell
mvn archetype:generate
```
Если указать только artefactId и groupId своего проекта, а остальные значения опставить пустыми (т.е. по умолчанию), то maven сгенерируют проект из архетипа **maven-archetype-quickstart** и мы получим такую структуру проекта
```
.
└── example
    ├── pom.xml
    └── src
        ├── main
        │   └── java
        │       └── org
        │           └── bigtheta
        │               └── mvn
        │                   └── App.java
        └── test
            └── java
                └── org
                    └── bigtheta
                        └── mvn
                            └── AppTest.java
```

Имеются тысячи уже готовых архетипов для разных фреймворков, и типов проектов. В том случае если у вас часто создаются проект с одинаковым сценарием, библиотеками и т.п. можно создать свой архетип.

---
## Жизненный цикл  

Maven использует понятие жизненного цикла. Жизненный цикл представляет собой последовательность фаз. Каждая фаза выполняет некоторое определенное действие. Выполнение происходит последовательно, т.е. сначала по порядку исполняются все предшествующие фазы, а затем исполняется указанная фаза. 

В maven имеются три преднастроенных жизненных цикла: **clean**, **default**, **site**

1. **clean** lifecycle - используется для очистки проекта. Имеет следующие фазы:
   * **pre-clean** - выполняет необходимые операции предшествующие очистке
   * **clean** - удаление всех файлов созданных в процессе сборки
   * **post-clean** - executes processes required to finalize project cleaning

2. **default** lifecycle - используется для процесса компиляции, тестирования и деплоймента. Он включает в себя более 20 фаз. Вот наиболее важные:

   * **validate** - проверяет что проект соответствует соглашениям и имеется вся информация необходимая для сборки
   * **compile** - компиляция исходного кода
   * **test** - запуск юнит тестов с использование тестового фреймворка.
   * **package** - упаковка компилированного кода в указанный формат
   * **integration-test** - загрузка сборки в тестовое окружение, проведения интеграционного тестирования
   * **verify** - проверка что созданная сборка удовлетворяет всем указанным критериям
   * **install** - загрузка сборки в локальный репозиторий
   * **deploy** - загрузка сборки в удаленный репозиторий

3. **site** lifecycle - включает в себя создание и загрузку на сервер проектной документации:
   * **pre-site** - исполняет действия предшествующие созданию документации
   * **site** - создание проектной документации
   * **post-site** - испольняет действия необходимые после создания документации
   * **site-deploy** - загрузка документации на сервер

### Исполнение цели
Для запуска определенный цели используется синтаксис:
```
mvn clean
```
Также можно указывать несколько целей:
```
mvn clean package
```
---
## Плагины

На фазы могут прикрепляться дополнительные действия при помощи механизма плагинов.

---
## Репозитории
Репозитории
* *Локальный репозиторий* (aka .m2)
* *Корпоративный репозиторий*
* *Центральный репозиторий*



---
## Управление зависимостями

```xml
<dependencies>
	<dependency>
		<groupId>...</groupId>
		<artifactId>...</artifactId>
		<version>...</version>
		<scope>...</scope>
	</dependency>
</dependencies>
```

Dependency scope


1. **compile**
2. **provided**
3. **runtime**
4. **test**
5. **system**
6. **import**
---


## Транзитивные зависимости


## Профили сборки




## Многомодульный проект

## Reactor

## BOM



## Интеграция с средами разработки



## Источники
1. Getting started guide: [https://maven.apache.org/guides/getting-started/index.html](https://maven.apache.org/guides/getting-started/index.html)
2. Maven: The Complete Reference (pdf) [http://books.sonatype.com/mvnref-book/pdf/mvnref-pdf.pdf](http://books.sonatype.com/mvnref-book/pdf/mvnref-pdf.pdf)
3. Apache Maven Cookbook(pdf) [https://www.javacodegeeks.com/wp-content/uploads/2016/09/Apache-Maven-Cookbook.pdf](https://www.javacodegeeks.com/wp-content/uploads/2016/09/Apache-Maven-Cookbook.pdf)
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---
---














































# Dependency management && build automation

Системы сборки
1. управление зависимостями
2. автоматицация сборки
3. поддержка версионирования

---
## Функциональность
* repeatable builds
* local repository
* dependency management
* build automation
* test automation
* deploy automation

## Build tool Java vs JavaScript vs Go

























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


