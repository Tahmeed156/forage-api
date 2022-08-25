# Generated by Django 4.0.6 on 2022-08-14 10:29

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0011_alter_submission_submitted'),
    ]

    operations = [
        migrations.AddField(
            model_name='submissioncomment',
            name='datetime',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='submissioncomment',
            name='submission',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.PROTECT, related_name='comments', to='api.submission'),
            preserve_default=False,
        ),
    ]
