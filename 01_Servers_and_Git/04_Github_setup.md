## Github setup

### Summary of steps
+ Create an account on Github
+ Create public/private SSH key on your machine
+ Add public SSH key to Github
+ Confirm SSH connection between your machine and Github is working


## Create an account at Github.com
Visit [Github.com](http://github.com) and create a free personal account if you don't already have one.


## SSH keys
To communicate with Github.com from your computer (via Git), we'll use the SSH protocol which will require SSH Keys.

<img src='http://making-the-internet.s3.amazonaws.com/vc-ssh-keys-illustrated@2x.png' style='max-width:766px;' alt=''>

>> &ldquo;SSH keys provide a more secure way of logging into a server rather than using a password alone. While a password can eventually be cracked with a brute force attack, SSH keys are nearly impossible to decipher by brute force alone. Generating a **key pair** provides you with two long string of characters: a **public and a private key**. You can place the public key on any server, and then unlock it by connecting to it with a client that already has the private key. When the two match up, the system unlocks without the need for a password.&rdquo; -[source](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

The other protocol option available with Github.com is *https*; this protocol requires less setup, but will require you to enter your Github.com credentials frequently when working with Git. Furthermore, you'll need SSH keys with your production server anyway, so knowing how to create and use them will be useful.


## Generate SSH keys on your computer
Via command line, move into the `.ssh` directory in your home directory.

__Mac__ users:
```bash
$ cd ~/.ssh
```

(FYI: `~/` is a shortcut for your home directory on Mac)

__Windows/Cmder__ users:
```bash
$ cd %home%\.ssh
```

(FYI: `%home%` is a shortcut for your home directory on Windows)

If a `.ssh` directory does not exist, create it and then navigate into it:

Mac:
```bash
$ mkdir ~/.ssh
$ cd ~/.ssh
```

Windows:
```bash
$ mkdir %home%\.ssh
$ cd %home%\.ssh
```

Next, we'll run a command to generate a new key pair, and we'll use the default key name of `id_rsa`. If you've created SSH keys in the past, this key pair might already exist; to check, run the list command `ls -la` in your `.ssh` directory to see if the files `id_rsa` and `id_rsa.pub` exist. If they do, skip down to the section *Add SSH key at Github.com* below.

If `id_rsa` keys do not exist, continue to generate a new key pair with this command:

```bash
$ ssh-keygen -t rsa -C "your_email@example.com"
```

When it asks you for a file name for the key, leave it blank so the default filename (`id_rsa`) is used. Example:

```xml
Enter file in which to save the key (/Users/YourName/.ssh/id_rsa): [Press enter]
```

When it asks you to create a passphrase you can enter one or leave it blank.

If you were building a real-world application that contained sensitive data, I recommend using a password on the SSH keys.
For course purposes, though, I suggest leaving the password blank because a) SSH keys are still super secure, even without a password and b) it's convenient to not have to enter a password each time you use the key.

Here's what DigitalOcean (the server provider we'll be using) has to say about passwords on SSH keys:

>> &ldquo;*It's up to you whether you want to use a passphrase. Entering a passphrase does have its benefits: the security of a key, no matter how encrypted, still depends on the fact that it is not visible to anyone else. Should a passphrase-protected private key fall into an unauthorized users possession, they will be unable to log in to its associated accounts until they figure out the passphrase, buying the hacked user some extra time. The only downside, of course, to having a passphrase, is then having to type it in each time you use the Key Pair.*&rdquo; -[source](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

Regardless of whether you enter a password or not, hit *Enter* to proceed, and then *Enter* again when it asks you to confirm your password.





## Add SSH key at Github.com

1. In Github.com, after logging in, go to **Settings** via the drop down menu below your Avatar on the top right.

2. Find the **SSH Keys** section.

3. Click **New SSH Key**.

<img src='http://making-the-internet.s3.amazonaws.com/vc-github-add-ssh-key@2x.png' class='' style='max-width:1000px; width:100%' alt='Github: Add a new SSH key'>

You'll then see a blank form to fill out the details for a new SSH key:

<img src='http://making-the-internet.s3.amazonaws.com/vc-blank-add-ssh-key@2x.png' class='' style='max-width:748px; width:100%' alt='Blank SSH key form'>


In the *Title* field come up with a name that will help you remember what machine this key will be used from; for example, I might choose `Susan's Macbook` to remind me this new key is connected to my laptop.

For the *Key* field, you want to paste the contents of the `id_rsa.pub` file that was generated on your computer in the above step.

To view this file in order to copy its contents, you can use the `cat` command:

```bash
$ cat id_rsa.pub
```

Your key will look something like this:

```bash
ssh-rsa [LONG STRING OF RANDOM CHARACTERS] your@email.com
```

Copy the entire contents of the key.

Tip for Windows users: To copy something from the Cmder window, simply select the text you wish to copy; it will automatically be added to your clipboard. If you have any issues with this, open the key file in Notepad and then copy it from there:

```bash
$ notepad id_rsa.pub
```

With the contents of `id_rsa.pub` in your clipboard, paste the contents into the *Key* textarea on Github.

<img src='http://making-the-internet.s3.amazonaws.com/vc-github-save-new-ssh-key@2x.png' style='max-width:746px; width:75%'>

Finally, click **Add SSH key**.

To test your new SSH key, run the following command to connect to Github over SSH:

```bash
$ ssh -T git@github.com
```

You may see this warning the first time you connect:

```xml
The authenticity of host 'github.com (207.97.227.239)' can't be established.
# RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
# Are you sure you want to continue connecting (yes/no)?
```

Type `yes` and hit *enter*.

If all went well, you should see this message:

```text
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

If that username is yours, you've successfully set up your SSH key.

If you receive a message saying access or permission is denied you can read [these instructions for diagnosing the issue](https://help.github.com/articles/error-permission-denied-publickey).
