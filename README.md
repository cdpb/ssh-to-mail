# SSH to Mail

If you don't want or can't install a mail daemon on every node this script will help you.

## Requirement
- OpenSSH Server
- Mail Daemon ( like ssmtp )

## Setup

### Client

- `cd ~/.ssh`
- `ssh-keygen -f ssh-to-mail`

### Server

- `cd /home`
- `git clone https://github.com/cdpb/ssh-to-mail.git`
- `<editor> /home/ssh-to-mail/mail.sh`
  - modify whitelist mails
- `useradd -d /home/ssh-to-mail -s /home/ssh-to-mail/mail.sh ssh-to-mail`
- `<editor> /home/ssh-to-mail/.ssh/authorized_keys`
  - add ssh-to-mail.pub
- `chown -R ssh-to-mail:ssh-to-mail /home/ssh-to-mail`

## Usage

sub can be empty, subject will be set to "SSH to Mail"

- `ssh -i ~/.ssh/ssh-to-mail ssh-to-mail@<host> "dst <mail> sub <subject> con <content>"`

### Example

- `ssh -i ~/.ssh/ssh-to-mail ssh-to-mail@<host> "dst example@whatever.com sub LOGFILE con $(cat /var/log/apache2/error.log)"`
