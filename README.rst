Modern Pet Project Hosting
==========================

This project:

* Enables you to setup a Docker machine on the VULTR cloud.
* Includes a docker-compose setup which shows how to run a project which serves files, Markdown, HTML, PHP and a reverse proxy Python app.

This project was demonstrated during the Eindhoven Developers Meetup at the 29th of March 2017.
The slides can be found `here <https://speakerdeck.com/ecno92/modern-pet-project-hosting>`_.

The demonstration was done on a laptop running Ubuntu Gnome 16.04 LTS.
The project is not adapted to run on Mac OS or Windows, but it may work.
It is advised to run this project on a Linux machine to avoid problems. Using a Virtual Machine should work.

Prepare your machine
--------------------

First we need to set some things up before you can launch this project.

* Get a VULTR account. You may use this `affiliate link <http://www.vultr.com/?ref=7140052>`_
* Install:

  - `Docker Engine/CLI <https://docs.docker.com/engine/getstarted/step_one/#step-2-install-docker>`_
  - `docker-machine <https://docs.docker.com/machine/install-machine/#installing-machine-directly>`_
  - `docker-machine-vultr driver <https://github.com/janeczku/docker-machine-vultr>`_
  - [Linux] `docker-compose <https://docs.docker.com/compose/install/>`_

* Get a domain to test with. We need to point a (subdomain) to the server to enable HTTPS.

Prepare the project
-------------------

* Git clone this project.

* Upload the contents of vultr-boot-script `as a startup (boot) script <https://my.vultr.com/startup/>`_.
  The startup script applies some changes to the machine at the first boot:

  - Enables the firewall to deny almost everything but ssh and the docker-machine port.
      + **HINT**: You may also configure the VULTR Firewall as an alternative.
  - Enables Ubuntu automatic security updates
  - Installs Fail2ban
  - Disables ssh password authentication (and restarts the sshd service)

* Edit `activate`. Fill in:

  - VULTR API Key (Can be found in your VULTR account)
  - VULTR_BOOT_SCRIPT ID. You can find the ID at the end of the URL when editing the VULTR Boot script:
    ``https://my.vultr.com/startup/manage/?SCRIPTID=THISISTHEID``
  - DOCKER_MACHINE_NAME. The name of how you want to name the machine. I used "vultr1" during my demonstration.

  - You may also change: (Not required for the demo)
      + `VULTR Region <https://www.vultr.com/api/#regions_region_list>`_
      + `VULTR Plan <https://www.vultr.com/api/#plans_plan_list>`_
      + VULTR_BACKUPS: "1" is enabled, "0" is disabled.
      + `VULTR OS <https://www.vultr.com/api/#os_os_list>`_

* Edit the environment variables in ``pet/docker-compose.production.yml``:

  - HOST: The domain you own and which you want to serve. E.g: subdomain.example.com
  - CADDY_TLS_EMAIL: your email for Let's Encrypt.


Create the docker-machine and run the example
---------------------------------------------

* Source the activate file: ``$ . activate``
* Create the docker-machine: ``$ make docker-machine-create-vultr-instance``
* Update the DNS of your domain. Point it to the VULTR Machine (A record). You can find the IP by executing: ``$ docker-machine ls`` in the URL column.
* Attach to the docker-machine instance. ``$ eval $(docker-machine env MACHINE_NAME)`` (replace MACHINE_NAME by the name of the docker-machine)
* You may want to run ``$ docker-machine active`` to find out if you are connected to the right machine.
* Move into the pet directory ``$ cd pet``
* Start the example project ``$ docker-compose -f docker-compose.base.yml -f docker-compose.production.yml up -d``

Now you can go to your domain with your browser. You should be able to see the example project running.
