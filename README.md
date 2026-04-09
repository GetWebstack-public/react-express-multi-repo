# react-express-multi-repo

A multi-repo project managed with [gws](https://getwebstack.com) (GetWebstack CLI). The workspace is defined in `gws.json` and contains two services:

| Service | Path | Description |
|---|---|---|
| `react-app` | `react-app/` | React frontend application |
| `express-server` | `express-server/` | Express.js backend server |

## Run the project

### 1. Install the GetWebstack CLI

```bash
curl -sSL https://getwebstack.com/install.sh | bash
```

### 2. Clone the repository

```bash
git clone https://github.com/GetWebstack-public/react-express-mono-repo
cd react-express-mono-repo
```

### 3. Initialize the workspace

```bash
gws init --from-file gws.json
```

Or, to regenerate the config:

```bash
gws init
```

### 4. Start all services

```bash
gws up
```

## Use as a template

Fork this repository to use it as a starting point for your own project.

## Project Structure

```
react-express-mono-repo/
├── gws.json           # Workspace definition
├── react-app/         # React frontend
└── express-server/    # Express backend
```
