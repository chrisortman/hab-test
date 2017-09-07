#!/bin/bash

hab svc load chrisortman/simple-node-1 --channel stable --strategy at-once
hab svc load chrisortman/dependent-node-1 --channel stable --strategy at-once
