# Introduction
This course is for engineers and scientists interested in quantitative finance and consulting. It covers financial systems, markets, and the fundamental assets and tools in quantitative finance. Additionally, it includes modeling, analysis, and simulation of fixed-income securities, equity instruments, and derivative products. The course also explores portfolio optimization, hedging strategies, and the statistical properties of financial data. It concludes with advanced topics such as the application of artificial intelligence to decision-making, providing students with tools for pursuing entrepreneurial and quantitative finance employment opportunities.

For more information on the course content, policies, procedures, and schedule, see the [2025-2026 Courses of Study](https://classes.cornell.edu/browse/roster/FA25/class/CHEME/5660).

## Installation Guide

This document walks you through installing four tools and wiring them together so you can launch **Julia**, **Jupyter**, and **VS Code** from your terminal on **Windows**, **macOS**, or **Linux**. Follow the steps in order, then run the “Smoke test” at the end.

> **Accuracy note.** The steps below have been double‑checked against current tooling: macOS uses **zsh** by default (not bash), Windows instructions use the correct **winget** ID for **juliaup**, and VS Code extension IDs/CLI commands are verified.


### Before you start

1. **Close** any terminals you already have open.
2. You’ll need a normal user account with permission to install software. On managed machines, use your IT‑recommended method.

---

### 1. Install Anaconda (latest)

**Windows/macOS/Linux**

1. Download **Anaconda Distribution** and run the installer.
2. When asked to “initialize conda,” say **Yes** (this adds `conda` to your shell so `jupyter` works on the command line).
3. After installation, open a **new terminal** and run:

```bash
conda --version
conda init  # only needed once if the installer didn’t do it
```

> Optional but recommended (keeps course work isolated):

```bash
conda create -n course python=3.11 jupyterlab
conda activate course
```

You should be able to run:

```bash
jupyter lab --version
```

---

### 2) Install Julia

Prefer **juliaup** (it manages versions and PATH for you).

**Windows (PowerShell)**

```powershell
winget install -e --id Julia.Juliaup
# then open a NEW PowerShell window
julia --version
```

**macOS (zsh) and Linux (bash/zsh)**

```bash
curl -fsSL https://install.julialang.org | sh
# Restart your terminal (or exec your shell) so PATH updates take effect
julia --version
```

> If you cannot use juliaup, download the Julia installer/tarball from julialang.org and add the `.../bin` directory to your PATH manually (see §6 and Appendix).

---

### 3) Install VS Code

**Windows/macOS/Linux**

1. Install **Visual Studio Code**.
2. Verify the `code` command is on your PATH:
   - **macOS (zsh)**: open VS Code → Command Palette (`⌘⇧P`) → “Shell Command: Install ‘code’ command in PATH”.
   - **Windows**: the installer can add `code` to PATH (re‑run installer if needed and check “Add to PATH”).
   - **Linux**: your package manager usually adds `code`; otherwise add it manually.

Check:

```bash
code --version
```

---

### 4) Install GitHub Desktop

**Windows/macOS**

1. Install **GitHub Desktop** and sign in with your GitHub account.
2. In GitHub Desktop → Preferences/Options → **Integrations**, set **External Editor** to **Visual Studio Code**.

> **Linux:** use the community build of GitHub Desktop (e.g., shiftkey/desktop) or `gh` (GitHub CLI) + VS Code’s built‑in Git.

---

### 5) Add VS Code extensions

Open VS Code, then install these extensions from the Extensions view:

1. **Jupyter** — `ms-toolsai.jupyter`
2. **Julia** — `julialang.language-julia`
3. **GitHub Copilot Chat** — `GitHub.copilot-chat`  
   - Sign in when prompted. Your institution may need to enable Copilot for your account.

> Prefer CLI? You can also run:
>
> ```bash
> code --install-extension ms-toolsai.jupyter
> code --install-extension julialang.language-julia
> code --install-extension GitHub.copilot-chat
> ```

---

### 6) Ensure **Julia** and **Jupyter** are on your PATH

You should be able to run `julia` and `jupyter` from any terminal. If the smoke test in §8 fails, use the appropriate fixes below.

#### Windows (PowerShell)

- **Conda/Jupyter**:

```powershell
conda init powershell   # adds conda to your PowerShell profile
# Restart PowerShell
jupyter lab --version
```

- **Julia via juliaup**: should already be on PATH. If `julia` is not found, sign out/in or run:

```powershell
$env:Path += ";$env:LOCALAPPDATA\Microsoft\WindowsApps"
julia --version
```

- **Julia via standalone installer**: add the Julia `bin` folder (e.g., `C:\Julia-1.x\bin`) to **System Properties → Environment Variables → Path**. Then restart your terminal.

#### macOS (zsh by default)

- **Conda/Jupyter**:

```bash
conda init zsh
exec zsh    # reloads shell
jupyter lab --version
```

- **Julia via juliaup**: the installer adds `~/.juliaup/bin` to your shell startup file. If `julia` isn’t found, add this to `~/.zshrc` (or `~/.zprofile`) and restart your terminal:

```bash
export PATH="$HOME/.juliaup/bin:$PATH"
```

#### Linux (bash or zsh)

- **Conda/Jupyter**:

```bash
conda init bash   # or: conda init zsh
exec $SHELL -l    # reloads your shell as a login shell
jupyter lab --version
```

- **Julia via juliaup**: if needed, add:

```bash
export PATH="$HOME/.juliaup/bin:$PATH"
```

to `~/.bashrc` or `~/.zshrc`, then restart the terminal.

---

### 7) Wire Julia into Jupyter (IJulia)

Open a terminal and start Julia:

```bash
julia
```

In the Julia REPL:

```julia
using Pkg
Pkg.add("IJulia")
```

This registers a **Julia** kernel with Jupyter. If you activated a conda env named `course`, keep using it for Jupyter:

```bash
conda activate course
jupyter lab
```

In JupyterLab → Launcher → you should see **Julia** listed under **Notebook** kernels.

> Optional: from Julia you can also launch directly with:
>
> ```julia
> using IJulia
> notebook()   # or: jupyterlab()
> ```

---

### 8) Smoke test (end‑to‑end)

1. **Terminal test**:

```bash
which julia  || where julia
which jupyter || where jupyter
code --version
julia --version
jupyter lab --version
```

2. **Jupyter test**: run `jupyter lab`, create a **Julia** notebook, and evaluate:

```julia
versioninfo()
sum(1:10)
```

3. **VS Code test**:
   - Open a folder in VS Code (`code .` from a terminal).
   - Command Palette → “Jupyter: Create New Jupyter Notebook”, select **Julia** as the kernel, run a cell.
   - Command Palette → “Julia: Start REPL” to confirm the Julia extension works.

4. **Git test**:
   - In GitHub Desktop, clone any test repo.
   - Open in VS Code, make a small change, commit, and push.

---

### 9) Common issues & quick fixes

- **`julia` not found after juliaup install (Windows)**: ensure `%LOCALAPPDATA%\Microsoft\WindowsApps` is on your PATH; sign out/in; open a new PowerShell window.
- **`jupyter` not found**: run `conda init <your shell>` and open a new terminal; or `conda activate course` if you created that environment.
- **Julia kernel missing in Jupyter**: in Julia, run `Pkg.add("IJulia")` again; then restart Jupyter. If multiple Pythons/Jupyters exist, prefer launching `jupyter lab` from the conda env you’ll use for class.
- **`code` not found (macOS)**: run “Shell Command: Install ‘code’ command in PATH” from VS Code.
- **Permission errors on macOS**: if the terminal lacks Full Disk Access, grant it in **System Settings → Privacy & Security**.

---

## Appendix: Manual PATH edits (only if you did not use juliaup/conda)

**Windows**
- Add `C:\Julia-1.x\bin` and your Anaconda paths (e.g., `C:\Users\<you>\anaconda3`, `...\anaconda3\Scripts`, `...\anaconda3\Library\bin`) to **Path** in **System Properties → Environment Variables**. Open a new terminal.

**macOS/Linux (zsh or bash)**
- Add to your shell startup file (`~/.zshrc` on macOS by default, `~/.bashrc` on many Linux distros):

```bash
export PATH="/path/to/Julia-1.x/bin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"   # or your Miniconda path
```

Then reload your shell:

```bash
exec $SHELL -l
```