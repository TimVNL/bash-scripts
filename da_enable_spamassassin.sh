#!/bin/bash
# A shell script to enable SpamAssassin with Low Threshold (5.0) when a new user is created in DirectAdmin
# Place this code in /usr/local/directadmin/scripts/custom/user_create_post.sh
# Written by: TimVNL
if [ "$spam" = "ON" ]; then
  echo "Enabling SpamAssassin with Low Threshold (5.0)"
  DIR=/home/$username/.spamassassin
  mkdir -p $DIR
  USERPREFS=$DIR/user_prefs
  if [ ! -s ${USERPREFS} ]; then
     echo 'required_score 5.0' > ${USERPREFS}
     echo 'rewrite_header subject *****SPAM*****' >> ${USERPREFS}
     echo 'report_safe 1' >> ${USERPREFS}
     chown $username:$username  ${USERPREFS}
     chmod 644 ${USERPREFS}
  fi
  chown  ${username}:mail $DIR
  chmod 771 $DIR
  if grep -m1 -q '^spamd=rspamd$' /usr/local/directadmin/custombuild/options.conf; then
      echo "action=rewrite&value=rspamd&user=${username}" >> /usr/local/directadmin/data/task.queue
  fi

  if [ "${domain}" != "" ]; then
     FILTERCONF=/etc/virtual/${domain}/filter.conf
     if [ ! -s ${FILTERCONF} ]; then
        echo 'high_score=15' > ${FILTERCONF}
        echo 'high_score_block=no' >> ${FILTERCONF}
        echo 'where=userspamfolder' >> ${FILTERCONF}
        chown mail:mail ${FILTERCONF}

        echo "action=rewrite&value=filter&user=$username" >> /usr/local/directadmin/data/task.queue
     fi
  fi
fi
exit 0;
