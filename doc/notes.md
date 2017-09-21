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

### Behaviour of services bound together

I run simple-node-1 and bound-node-1 
I had sn1 running first. when I started bn1 it worked Like I would expect.
When I stopped sn1 bn1 still functions, sn 1 does not
When I stop bn1 then it does not work, so now both are down

I was able to start bn1 without starting sn1 so it is able to resolve the configuration without the service 'running'

If I start and stop the supervisor like this then it comes back to the state it was in

Now because the sn1 service is stopped it wouldn't auto update, but I want to simulate what happens if I have the rails -base package auto update with the web package bound to but not dependent upon it

First I unloaded sn1, then I loaded it and made sure that it had an update strategy

I realized I've made a mistake and when I started my sn1 service I started it from the stable channel using a version of the package that does not expose the config needed for bn1.

bn1 didn't complain and used old config

But also my bound-node-1 package hasn't been using the bound value for it's port :(

**habitat version now 0.31.0**

Trying experiment again

```
hab svc load --channel stable --strategy at-once chrisortman/simple-node-1
hab svc load --channel stable --bind base:simple-node-1.default --strategy at-once chrisortman/bound-node-1
```

If I don't supply the bind information for bound node it doesn't start

When I supply it it starts

Now when I stop simple-node-1, it's definitely stopped but bound-node-1 is still going.
Stopping bound-node-1 and it stops

And I can start it again, so it doesn't rely on the service to be 'running' just that the information has been exported

Ok, so now I'm going to promote simplenode

If I promote and update the base package, the web package does not restart :(


--

I added hook files for each hook to simple-node-1 and had each print a line when they run

When I promoted the package, I saw post-run execute before run ?

I wondered if I dropped a new user.toml in simple-node-1 if it would be picked up automatically, looks like not


