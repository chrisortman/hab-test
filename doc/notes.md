Service auto updating

### Auto updating a single service

Starting simple-node-1 with `$NEW_SIMPLE_NODE` **not** in the `stable` channel

```
hab svc load --channel stable --strategy at-once chrisortman/simple-node-1
```

Will leave you with `$OLD_SIMPLE_NODE` running.

If you then promote `$NEW_SIMPLE_NODE`

```
hab pkg promote $NEW_SIMPLE_NODE stable
```

You will see the package eventually update in the supervisor and the `init` and `run` hooks will both be executed.

### Auto updating a single service when it has a service running that depends on it.

Starting simple-node-1 with `$NEW_SIMPLE_NODE` **not** in the `stable` channel

```
hab svc load --channel stable --strategy at-once chrisortman/simple-node-1
```

Start dependent-node-1. This service has a dependency on a version of simple-node-1 that is not yet in the stable channel

```
hab svc load chrisortman/dependent-node-1 --strategy at-once --channel stable --bind base:simple-node-1.default
```

_It seems when using the bind argument I have to put the package first?_

After I do this it is a little confusing. Because of the transitive dependency that exists between simple-node-1
and dependent-node-1 the new version (which is still in unstable) of simple-node-1 gets downloaded and is 'installed'
but it is not loaded / running because `hab sup status` still shows the old _stable_ version

But now, when I execute the `promote` command the simple-node-1 service will not be autoupdated by the supervisor. 
The new version will be used however when I restart the supervisor
