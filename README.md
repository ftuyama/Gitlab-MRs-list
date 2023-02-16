# Gitlab MR list

Tool to fetch a list of merge requests from your team!

## Setup

```bash
make setup
```

- You can generate your Gitlab token on: <https://gitlab.trainline.tools/-/profile/personal_access_tokens>

- This will setup GITLAB_URL, GITLAB_TOKEN and GITLAB_DEV_IDS env variables, e.g.:

```bash
GITLAB_URL=https://gitlab.com/api/v4
GITLAB_TOKEN=some-token-here
GITLAB_DEV_IDS=[787, 784, 792, 326, 397]
```

## Execution

- You can run it in the terminal:

```bash
make run
```

- Or spin up a web server:

```bash
make web
```

## Output

```bash
----------------------------------------------------------------------------------------------------
    https://gitlab.com/team/project/merge_requests/3035
    felipet - Update some API url
    ✓ 0C    2h ago

    https://gitlab.com/team/project2/merge_requests/9623
    felipet - Handle some timeout
    ✓ 0C    1d 3h ago

    https://gitlab.com/team/project2/merge_requests/9612
    felipet - Parameterize url
    ✓ 5C    2d 1h ago

    https://gitlab.com/team/project2/merge_requests/9584
    felipet - Blocks production error
    ✓ 2C    8d 19h ago

----------------------------------------------------------------------------------------------------
```
