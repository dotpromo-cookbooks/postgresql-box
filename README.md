dotpromo-postgresql-box Cookbook
================================
[![Build Status](https://travis-ci.org/dotpromo-cookbooks/postgresql-box.svg?branch=master)](https://travis-ci.org/dotpromo-cookbooks/postgresql-box)
PostgreSQL box lego part for your server

Requirements
------------
#### packages
- `postgresql` 

Attributes
----------
None

Usage
-----
#### dotpromo-postgresql-box::default

e.g.
Just include `dotpromo-postgresql-box` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dotpromo-postgresql-box]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Alexander Simonov <alex@simonov.me>
