# org.metadita.pdf.examplelist

Generate a list of examples in PDF output.

This plugin was prompted by an audience suggestion during the closing
panel of CMS/DITA North America in Durham. The suggestion was that DITA
should have an example list element to go along with the existing
`figurelist` and `tablelist` in Book maps. This sounded useful enough
that I put together a plug-in to support it. 

To get an example list topic, add the following element inside the
`booklists` element in your front matter:
`&lt;booklist outputclass="examplelist"&gt;`

## Not so simple after all

One thing this doesn't do is number the examples. I realized that
for my own builds, I always turn on generated task headings. As a 
result, tasks are full of sections with the title "Example". 
Should those be included in an example list? Possibly, but is
it useful to have a list with every entry titled "Example"?
For now, examples with generated titles are not included.

This raised a second question: should examples be numbered? 
Initially I thought yes, to go along with tables and figures,
but then the task examples got in the way -- do we really want
to suddenly see "Example 13. Example" in a task? Probably not.
How about just "Example 13"? More likely, but still uncertain.

For now, the examples are not numbered, and the list will contain
any example that has an authored title (not a generated title).

## Language support

The title for the list of examples is initially supported for
documents with the language set to English, Swedish, or Russian.
