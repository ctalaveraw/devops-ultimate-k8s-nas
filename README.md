# Table of Contents
- [Ultimate NAS - DevOps Edition](#ultimate-nas---devops-edition)
  - [About](#about)
  - [What Ultimate DevOps NAS Does](#what-ultimate-devops-nas-does)
  - [Stats](#stats)
    - [Project start](#project-start)
    - [View count](#view-count)
    - [Last update](#last-update)
  - [List of Self-Hosted NAS Applications to be Used](#list-of-self-hosted-nas-applications-to-be-used)
    - [Host Services](#host-services)
      - [CI/CD Pipelines \& Server Automation](#cicd-pipelines--server-automation)
        - [Alternative / optional choices](#alternative--optional-choices)
      - [Front-End](#front-end)
        - [Alternative / optional choices](#alternative--optional-choices-1)
      - [Infrastructure \& Application Management](#infrastructure--application-management)
        - [Alternative / optional choices](#alternative--optional-choices-2)
      - [Microservices](#microservices)
      - [Networking \& Remote Access](#networking--remote-access)
        - [Alternative / optional choices](#alternative--optional-choices-3)
      - [Security](#security)
      - [Utilities](#utilities)
        - [Alternative / optional choices](#alternative--optional-choices-4)
    - [Media Streaming](#media-streaming)
      - [Content Aggregation \& Management](#content-aggregation--management)
        - [Alternative / optional choices](#alternative--optional-choices-5)
      - [Content Downloading](#content-downloading)
        - [Alternative / optional choices](#alternative--optional-choices-6)
      - [Content Streaming](#content-streaming)
        - [Alternative / optional choices](#alternative--optional-choices-7)
    - [Miscellaneous](#miscellaneous)
      - [Private Cloud Storage](#private-cloud-storage)
      - [Smart Home Management](#smart-home-management)
        - [Alternative / optional choices](#alternative--optional-choices-8)
  - [Tech Stack](#tech-stack)
  - [Installation](#installation)
  - [Documentation](#documentation)
  - [Requirements](#requirements)

# Ultimate NAS - DevOps Edition (in-development)

## About

[![license](https://img.shields.io/github/license/DAVFoundation/api_doc.svg?style=for-the-badge)](https://github.com/davestephens/ansible-nas/blob/master/LICENSE)

This project draws inspiration from several other existing open source projects:

- [Perfect Media Server](https://perfectmediaserver.com/) - Open-source media server framework by [Alex Kretzschmar](https://github.com/ironicbadger), using Linux paired with [MergerFS](https://github.com/trapexit/mergerfs) (virtual, modular, configurable filesystem that allows for storage aggregation using different underlying filesystems) and [SnapRAID](http://www.snapraid.it/) (scriptable, self-healing software-based RAID targeted for home media centers) as an FOSS alternative for proprietary NAS solutions such as unRAID, OpenMediaVault, etc.
- [Ansible NAS](https://github.com/davestephens/ansible-nas) - NAS project by [David Stephens](https://github.com/davestephens), forking his project as the core Ansible deployment
- [Wolfgang's Home Server Ansible Playbook](https://github.com/notthebee/infra) - Ansible playbook for home server by Linux YouTuber [Wolfgang](https://www.youtube.com/c/WolfgangsChannel), pulling some application and config ideas from this project
- [DevOps Boilerplate Code](https://github.com/ChristianLempa/boilerplates) - Boilerplates for Terraform and Proxmox infrastructure deployments by [Christian Lempa](https://github.com/ChristianLempa)

## What Ultimate DevOps NAS Does

This intends to be a self-contained and automated provisioning and configuring of a feature-rich NAS host, with a flexible and modular configuration.

All services will be deployed via Ansible playbooks, with all services containerized with Docker.
The eventual goal is to migrate all services to Kubernetes (something for smaller-scale clusters like K3s, Minikube, etc.) at a later point.

There is complexity with this due to some services being stateful (any apps using a built-in SQLite DB like Sonarr, Jellyfin, etc.) or requiring sidecar pods (any apps requiring a separate DB container, such as Firefly, Gitea, NextCloud, etc.)

All services are meant to be optional and swappable with alternatives of one's choosing, as each service will be deployed with an Ansible playbook using `<SERVICE_NAME>_enabled` as a deployment variable.

Features include:

- Flexible storage and software-based RAID
- Front-end dashboard
  - Services Health Checks
  - Monitoring and Logging
- Home Automation dashboard
- Media server
  - Movies
  - TV Shows
  - eBooks
  - Comics/Manga
- Torrent management
  - Tracking
  - Auto Downloader
- Traefik Reverse Proxy
- Dynamic DNS
- Password Vault
- Private Cloud
  - File Storage
  - Photo Storage

Planned features include:
- End-to-end self-hosted CI/CD pipelines for deployment
  - Different environments for dev, staging and prod
- Using Kubernetes or Docker Swarm in place of just Docker
- Self-hosted MFA with Authelia

## Tech Stack

\* Badges generated by [Shields.io](https://shields.io/) \*

### Storage Pooling

[![MergerFS](https://img.shields.io/badge/-MergerFS-000000?style=plastic)](https://github.com/trapexit/mergerfs) - virtual, modular, configurable filesystem that allows for storage aggregation using different underlying filesystems

### Software RAID

[![SnapRAID](https://img.shields.io/badge/-SnapRAID-FFFFFF?style=plastic)](http://www.snapraid.it/) -  software-based RAID targeted for home media centers that allows for bitrot prevention, self-healing and scriptable scheduling of array sync

### Bare-metal Hypervisor

![Proxmox](https://img.shields.io/badge/-Proxmox-E57000?logo=proxmox&logoColor=black&style=for-the-badge)

### Source Control

![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

### Guest OS

![Ubuntu](https://img.shields.io/badge/Ubuntu%20LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

### Machine Image Creation

![Packer](https://img.shields.io/badge/packer-%23E7EEF0.svg?style=for-the-badge&logo=packer&logoColor=%2302A8EF)

### Infrastructure Provisioning

![Terrraform](https://img.shields.io/badge/Terraform-7B42BC?&style=for-the-badge&logo=Terraform&logoColor=white)

### Application/OS Provisioning

![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![cloud-init](https://img.shields.io/badge/cloudInit-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

### Application Infrastructure

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

### Filesystem

![ZFS](https://img.shields.io/badge/ZFS-2A667F?style=for-the-badge&logo=openzfs&logoColor=white)

### Remote Access

![SSH](https://img.shields.io/badge/-SSH-241F31?logo=gnome%20terminal&logoColor=white&style=for-the-badge)

### Reverse-Proxy / Load Balancer

![Traefik](https://img.shields.io/badge/-Traefik-EA9427?logo=traefikproxy&logoColor=white&style=for-the-badge)

### \*\*Future\*\*

![Jenkins](https://img.shields.io/badge/Jenkins-FFFFFF?style=for-the-badge&logo=jenkins&logoColor=red)
![Gitea](https://img.shields.io/badge/Gitea-acc98c?style=for-the-badge&logo=gitea&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-326ce5.svg?&style=for-the-badge&logo=kubernetes&logoColor=white)
![containerd](https://img.shields.io/badge/containerd-575757.svg?&style=for-the-badge&logo=containerd&logoColor=white)
![Authelia](https://img.shields.io/badge/Authelia-2a438c.svg?&style=for-the-badge&logo=authelia&logoColor=white)

## Stats

### Project start

[![Created](https://badges.strrl.dev/created/ctalaveraw/ultimate-devops-k8s-nas)](https://badges.strrl.dev)

### View count

[![Visits Badge](https://badges.strrl.dev/visits/ctalaveraw/ultimate-devops-k8s-nas)](https://badges.strrl.dev)

### Last update

[![Updated](https://badges.strrl.dev/updated/ctalaveraw/ultimate-devops-k8s-nas)](https://badges.strrl.dev)

## Host Services

### CI/CD Pipelines & Server Automation

- [![Jenkins](https://img.shields.io/badge/Jenkins-FFFFFF?style=plastic&logo=jenkins&logoColor=red)](https://jenkins.io) - Industry standard and extensible CI/CD engine

#### Alternative / optional choices

- [![GitLab CI](https://img.shields.io/badge/GitLab%20CI%20Runner-FC6D26?style=plastic&logo=gitlab&logoColor=white)](https://about.gitlab.com/features/) - Self-hosted CI/CD runner, feature-rich
- [n8n](https://n8n.io/) - Nodemation, a node based workflow and automation service like IFTTT.
- [Woodpecker-CI](https://woodpecker-ci.org) - a simple CI engine with great extensibility, forked from Drone.

### Front-End

- [Dashy](https://dashy.to/) - A self-hosted startpage for your server. Easy to use visual editor, status checking, widgets, themes and tons more!

#### Alternative / optional choices

- [Flame](https://github.com/pawelmalak/flame) (Another static home page)
- [Homer](https://hub.docker.com/r/b4bz/homer) (A static home page)
- [Krusader](https://krusader.org/) - Twin panel file management for your desktop
- [Organizr](https://organizr.app/) - ORGANIZR aims to be your one stop shop for your Servers Frontend.

### Infrastructure & Application Management

- [![Grafana](https://img.shields.io/badge/-Grafana-F46800?logo=Grafana&logoColor=white&style=plastic)](https://grafana.com/) - Query, visualize, alert on, and understand your data no matter where it’s stored (via stats role).
- [![Portainer](https://img.shields.io/badge/-Portainer-13BEF9?logo=Portainer&logoColor=white&style=plastic)](https://portainer.io/) - for managing Docker and running custom images
- [![Prometheus](https://img.shields.io/badge/-Prometheus-E6522C?logo=Prometheus&logoColor=white&style=plastic)](https://prometheus.io/) - Time series database and monitoring system (via stats role).

#### Alternative / optional choices

- [healthchecks.io](https://healthchecks.io/) - Ensure your NAS is online and get notified otherwise
- [Netdata](https://my-netdata.io/) - An extremely comprehensive system monitoring solution
- [Tautulli](http://tautulli.com/) - Monitor Your Plex Media Server
- [Watchtower](https://github.com/v2tec/watchtower) - Monitor your Docker containers and update them if a new version is available

### Microservices

- [![Eclipse Mosquitto](https://img.shields.io/badge/-Eclipse%20Mosquitto-3C5280?logo=Eclipse%20Mosquitto&logoColor=white&style=plastic)](https://mosquitto.org/) - An open source MQTT broker
- [Gotify](https://gotify.net/) - Self-hosted server for sending push notifications

### Networking & Remote Access

- [![CloudFlare DDNS](https://img.shields.io/badge/-CloudFlare%20DDNS-F38020?logo=CloudFlare&logoColor=white&style=plastic)](https://hub.docker.com/r/joshuaavalon/cloudflare-ddns/) - automatically update Cloudflare with your IP address
- [![UniFi Controller](https://img.shields.io/badge/-UniFi%20Controller-0559C9?logo=ubiquiti&logoColor=white&style=plastic)](https://hub.docker.com/r/linuxserver/unifi-controller) (A controller for UniFi devices such as routers and Access Points)
- [Guacamole](https://guacamole.apache.org/) - Web based remote desktop gateway, supports VNC, RDP and SSH
- [DuckDNS](https://hub.docker.com/r/linuxserver/duckdns/) (A dynamic DNS client for DuckDNS)

#### Alternative / optional choices

- [![Bunkerized NGINX](https://img.shields.io/badge/-Bunkerized%20NGINX-009639?logo=CloudFlare&logoColor=white&style=plastic)](https://github.com/bunkerity/bunkerized-nginx) - A NGINX-based web server focused on security; needs Certbot + fail2ban)
- [netboot.xyz](https://netboot.xyz/) - a PXE boot server
- [SWAG](https://hub.docker.com/r/linuxserver/swag) (A reverse proxy with built-in support for dynamic DNS, Certbot and fail2ban)

### Security

- [![Traefik Proxy](https://img.shields.io/badge/-Traefik%20Proxy-24A1C1?logo=Traefik%20Proxy&logoColor=white&style=plastic)](https://traefik.io/) - Web proxy and SSL certificate manager
- [![Vaultwarden](https://img.shields.io/badge/-Vaultwarden-175DDC?logo=Bitwarden&logoColor=white&style=plastic)](https://hub.docker.com/r/vaultwarden/server) - A FOSS Bitwarden fork written in Rust


#### Future implementation
- [Authelia](https://hub.docker.com/r/authelia/authelia) - An authentication provider

### Utilities

- [Syncthing](https://syncthing.net/) - sync directories with another device
- [Code Server](https://code.visualstudio.com/) - Powerful IDE from Microsoft accessible through the browser

### Media Streaming

#### Content Aggregation & Management

- [Radarr](https://radarr.video/) - for organising and downloading movies
- [Sonarr](https://sonarr.tv/) - for downloading and managing TV episodes
- [Bazarr](https://github.com/morpheus65535/bazarr) - companion to Radarr and Sonarr for downloading subtitles
- [Lidarr](https://github.com/lidarr/Lidarr) - Music collection manager for Usenet and BitTorrent users
- [Mylar](https://github.com/evilhero/mylar) - An automated Comic Book downloader (cbr/cbz) for use with SABnzbd, NZBGet and torrents
- [Prowlarr](https://github.com/Prowlarr/Prowlarr) - Indexer aggregator for Sonarr, Radarr, Lidarr, etc.
- [Jackett](https://github.com/Jackett/Jackett) - API Support for your favorite torrent trackers
- [YouTubeDL-Material](https://github.com/Tzahi12345/YoutubeDL-Material) - Self-hosted YouTube downloader built on Material Design

##### Alternative / optional choices

- [Overseerr](https://docs.overseerr.dev) - open source software application for managing requests for your media library; front end replacement for Sonarr and Radarr
- [CouchPotato](https://couchpota.to/) - for downloading and managing movies

#### Content Downloading

- [arch-delugevpn](https://hub.docker.com/r/binhex/arch-delugevpn) (An Arch Linux container running Deluge and an Wireguard/OpenVPN client with a kill switch)

##### Alternative / optional choices

- [Transmission](https://transmissionbt.com/) - BitTorrent client (with OpenVPN if you have a supported VPN provider)
- [pyLoad](https://pyload.net/) - A download manager with a friendly web-interface

#### Content Streaming

- [![Jellyfin](https://img.shields.io/badge/-Jellyfin-00A4DC?logo=jellyfin&logoColor=white&style=plastic)](https://jellyfin.github.io) - The Free Software Media System
- [![Plex](https://img.shields.io/badge/-Plex-E5A00D?logo=plex&logoColor=white&style=plastic)](https://www.plex.tv/) - Plex Media Server
- [Airsonic](https://airsonic.github.io/) - catalog and stream music
- [Navidrome](https://www.navidrome.org/) - Modern Music Server and Streamer compatible with Subsonic/Airsonic
- [Komga](https://komga.org/) - a media server for your comics, mangas, BDs and magazines
- [Calibre-web](https://github.com/janeczku/calibre-web) - Provides a clean interface for browsing, reading and downloading eBooks using an existing Calibre database.
- [Paperless_ng](https://github.com/jonaswinkler/paperless-ng) - Scan, index and archive all your physical documents

##### Alternative / optional choices

- [![Piwigo](https://img.shields.io/badge/-Piwigo-FF7700?logo=piwigo&logoColor=white&style=plastic)](https://piwigo.org/) - Photo Gallery Software
- [Booksonic](https://hub.docker.com/r/linuxserver/booksonic) (An audiobook server)
- [Miniflux](https://miniflux.app/) - An RSS news reader
- [Ubooquity](http://vaemendis.net/ubooquity/) - Book and comic server

### Miscellaneous

#### Private Cloud Storage

- [![Nextcloud](https://img.shields.io/badge/-Nextcloud-0092C9?logo=Nextcloud&logoColor=white&style=plastic)](https://nextcloud.com/) - A self-hosted Dropbox alternative

#### Smart Home Management

- [![Home Assistant](https://img.shields.io/badge/-Home%20Assistant-41BDF5?logo=Home%20Assistant&logoColor=white&style=plastic)](https://www.home-assistant.io) - Open source home automation

##### Alternative / optional choices

- [openHAB](https://www.openhab.org/) - A vendor and technology agnostic open source automation software for your home; Alternative to Home Assistant
