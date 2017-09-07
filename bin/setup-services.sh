#!/bin/bash

hab svc unload chrisortman/simple-node-1
hab svc unload chrisortman/dependent-node-1

hab svc load chrisortman/simple-node-1 --channel stable --strategy at-once
hab svc load chrisortman/dependent-node-1 --channel stable --strategy at-once --bind base:simple-node-1.default
