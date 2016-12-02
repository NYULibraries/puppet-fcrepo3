# fedora_repo

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with fedora_repo](#setup)
    * [What fedora_repo affects](#what-fedora_repo-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with fedora_repo](#beginning-with-fedora_repo)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages the Fedora 3 repository

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What fedora_repo affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with fedora_repo


## Usage

To install Fedora3.

    include fcrepo3

By default this will install fedora 3.7.1, retrieving the artifact from MAven Central. To install Fedora 3.8 you can do the following,

    class { 'fcrepo3' :
      version => '3.8.1',
    }

To pull the artifact from a local Nexus server,

    class { 'fcrepo3' :
      nexus_server => 'nexus.example.edu',
      nexus_port   => '8081',
    }

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This module has been tested on CentOS 6 with Fedora 3.7 and 3.8.  

## Development

This module uses the params.pp pattern with hiera compatibility.  It might work as is for installing Fedora 4, but I haven't tested it yet.  Pull requests are welcome.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.

