# Generated by Django 4.0.6 on 2022-08-27 08:57

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0020_submissioncomment_hightlight_pos_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='submissioncomment',
            old_name='hightlight_pos',
            new_name='highlight_metadata',
        ),
    ]
