////////////////////////////////////////////////////////////////
//
//  freeling.i
//  This is the SWIG input file, used to generate java/perl/python APIs.
//
////////////////////////////////////////////////////////////////
 
%rename(operator_assignment) operator=;

///////////////  FREELING LANGUAGE DATA CLASSES /////////////

namespace freeling {

  template<class T> class tree_preorder_iterator;
  template<class T> class const_tree_preorder_iterator;
  template<class T> class tree_sibling_iterator;
  template<class T> class const_tree_sibling_iterator;

template <class T> 
class tree { 

 public:
   /// iterator types for tree<T>
   typedef tree_preorder_iterator<T> preorder_iterator;
   typedef tree_sibling_iterator<T> sibling_iterator;
   /// default tree iterator is preorder
   typedef preorder_iterator iterator;
   
   /// const iterator types for tree<T>
   typedef const_tree_preorder_iterator<T> const_preorder_iterator;
   typedef const_tree_sibling_iterator<T> const_sibling_iterator;
   /// default tree const iterator is preorder
   typedef const_preorder_iterator const_iterator;

   /// constuctor
   tree();
   tree(const T&);
   tree(const const_iterator&);
   /// copy
   tree(const tree<T>&);
   /// assignment
   tree<T>& operator=(const tree<T>&);
   /// destructor
   ~tree();

   /// clear tree content
   void clear();
   /// check whether the node is the root of the tree 
   /// (that is, it has no further parent above)
   bool is_root() const;
   /// check whether the tree is empty (no nodes)
   bool empty() const;
   /// number of children of the tree
   unsigned int num_children() const;
   /// see if the tree is somewhere under given tree
   bool has_ancestor(const tree<T> &) const;
   
   sibling_iterator nth_child(unsigned int);
   tree<T>& nth_child_ref(unsigned int);
   
   /// copy given tree and add it as a child
   void add_child(const tree<T>& t, bool last=true);
   /// add given tree and as a child reordering structure. NO COPIES MADE.
   void hang_child(tree<T>& t, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
   void hang_child(preorder_iterator &p, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
   void hang_child(sibling_iterator &p, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
   
   /// get iterator to parent node
   preorder_iterator get_parent();
   
   preorder_iterator begin();
   preorder_iterator end();
   
   sibling_iterator sibling_begin();
   sibling_iterator sibling_end();
   sibling_iterator sibling_rbegin();
   sibling_iterator sibling_rend();

   #if !defined(FL_API_JAVA)
   const_sibling_iterator nth_child(unsigned int) const;
   const tree<T>& nth_child_ref(unsigned int) const;
   const_preorder_iterator get_parent() const;
   const_preorder_iterator begin() const;
   const_preorder_iterator end() const;
   const_sibling_iterator sibling_begin() const;
   const_sibling_iterator sibling_end() const;
   const_sibling_iterator sibling_rbegin() const;
   const_sibling_iterator sibling_rend() const;
   #endif
};
 

/// ############################################################# ///
///
///                    TREE  ITERATORS
///
/// ############################################################# ///


  ////////////////////////////////////////////////////////////////////////////    
  /// preorder iterator. Inherits form basic_preorder and from basic_nonconst

  template<class T> class tree_preorder_iterator {
    public: 
      tree_preorder_iterator();
      tree_preorder_iterator(tree<T> *p);
      tree_preorder_iterator(const tree_preorder_iterator<T> &p);
      tree_preorder_iterator(const tree_sibling_iterator<T> &p);
      ~tree_preorder_iterator();

      tree_preorder_iterator<T> operator++(int);
      tree_preorder_iterator<T>& operator++();
      tree_preorder_iterator<T> operator--(int);
      tree_preorder_iterator<T>& operator--();
      // for python and other APIs
      void incr();
      void decr();

      bool operator==(const tree_preorder_iterator<T> &t) const;
      bool operator!=(const tree_preorder_iterator<T> &t) const;      

      /// ---------------------- Non const operations
      T& operator*() const;
      T* operator->() const;
      /// emulate operator -> for java/python/perl APIS
      T* get_info() const;

      /// check whether the iterator points somewhere.
      bool is_defined() const;
      /// access to tree operations via iterator
      bool is_root() const;
      bool empty() const;
      bool has_ancestor(const tree<T> &p) const;
      unsigned int num_children() const;

      /// get iterator to parent node
      tree_preorder_iterator<T> get_parent();
      // get iterator to nth child
      tree_sibling_iterator<T> nth_child(unsigned int);
      // get reference to nth child (Useful for Java API)
      tree<T>& nth_child_ref(unsigned int);

      /// iterators begin/end
      tree_preorder_iterator<T> begin();
      tree_preorder_iterator<T> end();
      tree_sibling_iterator<T> sibling_begin();
      tree_sibling_iterator<T> sibling_end();
      tree_sibling_iterator<T> sibling_rbegin();
      tree_sibling_iterator<T> sibling_rend();

      /// copy given tree and add it as a child
      void add_child(const tree<T>& t, bool last=true);
      /// add given tree and as a child reordering structure. NO COPIES MADE.      
      void hang_child(tree<T>& t, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
      void hang_child(tree_preorder_iterator<T> &p, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
      void hang_child(tree_sibling_iterator<T> &p, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
  };

  ////////////////////////////////////////////////////////////////////////////    
  /// sibling iterator. Inherits form basic_sibling and from basic_nonconst

  template<class T> class tree_sibling_iterator {
    public: 
      tree_sibling_iterator();
      tree_sibling_iterator(tree<T> *p);
      tree_sibling_iterator(const tree_sibling_iterator<T> &p);
      tree_sibling_iterator(const tree_preorder_iterator<T> &p);
      ~tree_sibling_iterator();

      tree_sibling_iterator<T> operator++(int);
      tree_sibling_iterator<T>& operator++();
      tree_sibling_iterator<T> operator--(int);
      tree_sibling_iterator<T>& operator--();
      // for python and other APIs
      void incr();
      void decr();

      /// ---------------------- Non const operations
      T& operator*() const;
      T* operator->() const;
      /// emulate operator -> for java/python/perl APIS
      T* get_info() const;

      bool operator==(const tree_sibling_iterator<T> &t) const;
      bool operator!=(const tree_sibling_iterator<T> &t) const;      

      /// get iterator to parent node
      tree_preorder_iterator<T> get_parent();
      // get iterator to nth child
      tree_sibling_iterator<T> nth_child(unsigned int);
      // get reference to nth child (Useful for Java API)
      tree<T>& nth_child_ref(unsigned int);

      /// check whether the iterator points somewhere.
      bool is_defined() const;
      /// access to tree operations via iterator
      bool is_root() const;
      bool empty() const;
      bool has_ancestor(const tree<T> &p) const;
      unsigned int num_children() const;

      /// iterators begin/end
      tree_preorder_iterator<T> begin();
      tree_preorder_iterator<T> end();
      tree_sibling_iterator<T> sibling_begin();
      tree_sibling_iterator<T> sibling_end();
      tree_sibling_iterator<T> sibling_rbegin();
      tree_sibling_iterator<T> sibling_rend();

      /// copy given tree and add it as a child
      void add_child(const tree<T>& t, bool last=true);
      /// add given tree and as a child reordering structure. NO COPIES MADE.      
      void hang_child(tree<T>& t, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
      void hang_child(tree_preorder_iterator<T> &p, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
      void hang_child(tree_sibling_iterator<T> &p, tree_sibling_iterator<T> where=tree_sibling_iterator<T>(NULL));
  };

  ////////////////////////////////////////////////////////////////////////////    
  /// const tree_preorder iterator. Inherits form basic_preorder and from basic_const

  template<class T> class const_tree_preorder_iterator {
    public: 
      const_tree_preorder_iterator();
      const_tree_preorder_iterator(const tree<T> *p);
      const_tree_preorder_iterator(const tree_preorder_iterator<T> &p);
      const_tree_preorder_iterator(const tree_sibling_iterator<T> &p);
      const_tree_preorder_iterator(const const_tree_preorder_iterator<T> &p);
      const_tree_preorder_iterator(const const_tree_sibling_iterator<T> &p);
      ~const_tree_preorder_iterator();

      /// ---------------------- const operations
      const T& operator*() const;
      const T* operator->() const;

      const_tree_preorder_iterator<T> operator++(int);
      const_tree_preorder_iterator<T>& operator++();
      const_tree_preorder_iterator<T> operator--(int);
      const_tree_preorder_iterator<T>& operator--();
      // for python and other APIs
      void incr();
      void decr();

      bool operator==(const const_tree_preorder_iterator<T> &t) const;
      bool operator!=(const const_tree_preorder_iterator<T> &t) const;      

      /// emulate operator -> for java/python/perl APIS
      const T* get_info() const;

      /// check whether the iterator points somewhere.
      bool is_defined() const;
      /// access to tree operations via iterator
      bool is_root() const;
      bool empty() const;
      bool has_ancestor(const tree<T> &p) const;
      unsigned int num_children() const;

      /// get iterator to parent node
      const_tree_preorder_iterator<T> get_parent() const;
      /// get nth child
      const_tree_sibling_iterator<T> nth_child(unsigned int n) const;
      const tree<T> & nth_child_ref(unsigned int n) const;
      /// iterators
      const_tree_preorder_iterator<T> begin() const;
      const_tree_preorder_iterator<T> end() const;
      const_tree_sibling_iterator<T> sibling_begin() const;
      const_tree_sibling_iterator<T> sibling_end() const;
      const_tree_sibling_iterator<T> sibling_rbegin() const;
      const_tree_sibling_iterator<T> sibling_rend() const;
  };

  ////////////////////////////////////////////////////////////////////////////    
  /// const sibling iterator. Inherits form basic_sibling and from basic_const

  template<class T> class const_tree_sibling_iterator {
    public: 
      const_tree_sibling_iterator();
      const_tree_sibling_iterator(const tree<T> *p);
      const_tree_sibling_iterator(const tree_sibling_iterator<T> &p);
      const_tree_sibling_iterator(const tree_preorder_iterator<T> &p);
      const_tree_sibling_iterator(const const_tree_sibling_iterator<T> &p);
      const_tree_sibling_iterator(const const_tree_preorder_iterator<T> &p);
      ~const_tree_sibling_iterator();

      /// ---------------------- const operations
      const T& operator*() const;
      const T* operator->() const;

      const_tree_sibling_iterator<T> operator++(int);
      const_tree_sibling_iterator<T>& operator++();
      const_tree_sibling_iterator<T> operator--(int);
      const_tree_sibling_iterator<T>& operator--();
      // for python and other APIs
      void incr();
      void decr();

      bool operator==(const const_tree_sibling_iterator<T> &t) const;
      bool operator!=(const const_tree_sibling_iterator<T> &t) const;

      /// emulate operator -> for java/python/perl APIS
      const T* get_info() const;

      /// check whether the iterator points somewhere.
      bool is_defined() const;
      /// access to tree operations via iterator
      bool is_root() const;
      bool empty() const;
      bool has_ancestor(const tree<T> &p) const;
      unsigned int num_children() const;

      /// get iterator to parent node
      const_tree_preorder_iterator<T> get_parent() const;
      /// get nth child
      const_tree_sibling_iterator<T> nth_child(unsigned int n) const;
      const tree<T> & nth_child_ref(unsigned int n) const;
      /// iterators
      const_tree_preorder_iterator<T> begin() const;
      const_tree_preorder_iterator<T> end() const;
      const_tree_sibling_iterator<T> sibling_begin() const;
      const_tree_sibling_iterator<T> sibling_end() const;
      const_tree_sibling_iterator<T> sibling_rbegin() const;
      const_tree_sibling_iterator<T> sibling_rend() const;
  };

 %template(TreeOfNode) tree<freeling::node>;
 %template(TreeOfDepnode) tree<freeling::depnode>;

 %template(TreePreorderIteratorNode) tree_preorder_iterator<freeling::node>;
 %template(TreeSiblingIteratorNode) tree_sibling_iterator<freeling::node>; 

 %template(TreePreorderIteratorDepnode) tree_preorder_iterator<freeling::depnode>;
 %template(TreeSiblingIteratorDepnode) tree_sibling_iterator<freeling::depnode>;
 
 %template(TreeConstPreorderIteratorNode) const_tree_preorder_iterator<freeling::node>;
 %template(TreeConstSiblingIteratorNode) const_tree_sibling_iterator<freeling::node>; 
 %template(TreeConstPreorderIteratorDepnode) const_tree_preorder_iterator<freeling::depnode>;
 %template(TreeConstSiblingIteratorDepnode) const_tree_sibling_iterator<freeling::depnode>;

class analysis {
   public:
      /// user-managed data, we just store it.
      std::vector<std::wstring> user;

      /// constructor
      analysis();
      /// constructor
      analysis(const std::wstring &, const std::wstring &);
      /// assignment
      analysis& operator=(const analysis&);
      ~analysis();

      void init(const std::wstring &l, const std::wstring &t);
      void set_lemma(const std::wstring &);
      void set_tag(const std::wstring &);
      void set_prob(double);
      void set_distance(double);
      void set_retokenizable(const std::list<freeling::word> &);

      bool has_prob() const;

      bool has_distance() const;
      std::wstring get_lemma() const;
      std::wstring get_tag() const;
      double get_prob() const;
      double get_distance() const;
      bool is_retokenizable() const;
      std::list<freeling::word> get_retokenizable() const;

      std::list<std::pair<std::wstring,double> > get_senses() const;
      void set_senses(const std::list<std::pair<std::wstring,double> > &);
      // useful for java API
      std::wstring get_senses_string() const;

      /// Comparison to sort analysis by *decreasing* probability
      bool operator>(const analysis &) const;
      /// Comparison to sort analysis by *increasing* probability
      bool operator<(const analysis &) const;
      /// Comparison (to please MSVC)
      bool operator==(const analysis &) const;

      // find out whether the analysis is selected in the tagger
      // k-th best sequence
      bool is_selected(int k=0) const;
      // mark this analysis as selected in k-th best sequence
      void mark_selected(int k=0);
      // unmark this analysis as selected in k-th best sequence
      void unmark_selected(int k=0);
};


////////////////////////////////////////////////////////////////
///   Class alternative stores all info related to a word
///  alternative spelling: form, edit distance
////////////////////////////////////////////////////////////////
 
class alternative {
  
  public:
    /// constructor
    alternative();
    /// constructor
    alternative(const std::wstring &);
    /// constructor
    alternative(const std::wstring &, const int);
    /// Copy constructor
    alternative(const alternative &);
    /// assignment
    alternative& operator=(const alternative&);
    /// comparison
    bool operator==(const alternative&) const;

    /// Get form of the alternative
    std::wstring get_form() const;
    /// Get edit distance
    int get_distance() const;
    /// Get edit distance probability
    float get_probability() const;
    /// Whether the alternative is selected in the kbest path or not
    bool is_selected(int k = 1) const;
    /// Clear the kbest selections
    void clear_selections();
    /// Add a kbest selection
    void add_selection(int);
    
    /// Set alternative form
    void set_form(const std::wstring &);
    /// Set alternative distance
    void set_distance(int);
    /// Set alternative probability
    void set_probability(float);
};


////////////////////////////////////////////////////////////////
///   Class word stores all info related to a word: 
///  form, list of analysis, list of tokens (if multiword).
////////////////////////////////////////////////////////////////

class word : public std::list<freeling::analysis> {
   public:
     // morphological modules that may add analysis to the word
     typedef enum  { USERMAP=0x0001,    NUMBERS=0x0002,       PUNCTUATION=0x0004,
                     DATES=0x0008,      DICTIONARY=0x0010,    AFFIXES=0x0020,
                     COMPOUNDS=0x0040,  MULTIWORDS=0x0080,    NER=0x0100, 
                     QUANTITIES=0x0200, PROBABILITIES=0x0400, GUESSER=0x0800 } Modules;

      /// user-managed data, we just store it.
      std::vector<std::wstring> user;

      /// constructor
      word();
      /// constructor
      word(const std::wstring &);
      /// constructor
      word(const std::wstring &, const std::list<freeling::word> &);
      /// constructor
      word(const std::wstring &, const std::list<freeling::analysis> &, const std::list<freeling::word> &);
      /// Copy constructor
      word(const word &);
      /// assignment
      word& operator=(const word&);

      ~word();

      /// copy analysis from another word
      void copy_analysis(const word &);
      /// Get the number of selected analysis
      int get_n_selected() const;
      /// get the number of unselected analysis
      int get_n_unselected() const;
      /// true iff the word is a multiword compound
      bool is_multiword() const;
      /// true iff the word is a multiword marked as ambiguous
      bool is_ambiguous_mw() const;
      /// set mw ambiguity status
      void set_ambiguous_mw(bool);
      /// get number of words in compound
      int get_n_words_mw() const;
      /// get word objects that compound the multiword
      const std::list<freeling::word> &get_words_mw() const;
      /// get word form
      std::wstring get_form() const;
      /// Get word form, lowercased.
      std::wstring get_lc_form() const;
      /// Get word phonetic form
      std::wstring get_ph_form() const;
      /// Get an iterator to the first selected analysis
      word::iterator selected_begin(int k=0);
      /// Get an iterator to the end of selected analysis list
      word::iterator selected_end(int k=0);
      /// Get an iterator to the first unselected analysis
      word::iterator unselected_begin(int k=0);
      /// Get an iterator to the end of unselected analysis list
      word::iterator unselected_end(int k=0);

      #ifndef FL_API_JAVA
      /// Get an iterator to the first selected analysis
      word::const_iterator selected_begin(int k=0) const;
      /// Get an iterator to the end of selected analysis list
      word::const_iterator selected_end(int k=0) const;
      /// Get an iterator to the first unselected analysis
      word::const_iterator unselected_begin(int k=0) const;
      /// Get an iterator to the end of unselected analysis list
      word::const_iterator unselected_end(int k=0) const;
      #endif

      /// Get how many kbest tags the word has
      unsigned int num_kbest() const;
      /// get lemma for the selected analysis in list
      std::wstring get_lemma(int k=0) const;
      /// get tag for the selected analysis
      std::wstring get_tag(int k=0) const;

      /// get sense list for the selected analysis
      std::list<std::pair<std::wstring,double> > get_senses(int k=0) const;
      // useful for java API
      std::wstring get_senses_string(int k=0) const;
      /// set sense list for the selected analysis
      void set_senses(const std::list<std::pair<std::wstring,double> > &,int k=0);

      /// get token span.
      unsigned long get_span_start() const;
      unsigned long get_span_finish() const;

      /// check if there is any retokenizable analysis
      bool has_retokenizable() const;
      /// mark word as having definitive analysis
      void lock_analysis();
      /// unmark word as having definitive analysis
      void unlock_analysis();
      /// check if word is marked as having definitive analysis
      bool is_locked_analysis() const;
      /// mark word as non-multiwordable
      void lock_multiwords();
      /// unmark word as non-multiwordable
      void unlock_multiwords();
      /// check if word is marked as not being multiwordable
      bool is_locked_multiwords() const;

      /// control which maco modules added analysis to this word
      void set_analyzed_by(unsigned);
      bool is_analyzed_by(unsigned) const;
      unsigned get_analyzed_by() const;
      
      /// add an alternative to the alternatives list
      void add_alternative(const freeling::alternative &);
      /// add an alternative to the alternatives list
      void add_alternative(const std::wstring &, int);
      /// replace alternatives list with list given
      void set_alternatives(const std::list<std::pair<std::wstring,int> > &);
      /// clear alternatives list
      void clear_alternatives();
      /// find out if the speller checked alternatives
      bool has_alternatives() const;

      /// get alternatives list &
      std::list<freeling::alternative>& get_alternatives();
      /// get alternatives begin iterator
      std::list<freeling::alternative>::iterator alternatives_begin();
      /// get alternatives end iterator
      std::list<freeling::alternative>::iterator alternatives_end();
      
      #ifndef FL_API_JAVA
      /// get alternatives list const &
      const std::list<freeling::alternative>& get_alternatives() const;
      /// get alternatives begin iterator
      std::list<freeling::alternative>::const_iterator alternatives_begin() const;
      /// get alternatives end iterator
      std::list<freeling::alternative>::const_iterator alternatives_end() const;
      #endif

      /// add one analysis to current analysis list  (no duplicate check!)
      void add_analysis(const analysis &);
      /// set analysis list to one single analysis, overwriting current values
      void set_analysis(const analysis &);
      /// set analysis list, overwriting current values
      void set_analysis(const std::list<freeling::analysis> &);
      /// set word form
      void set_form(const std::wstring &);
      /// Set word phonetic form
      void set_ph_form(const std::wstring &);
      /// set token span
      void set_span(unsigned long, unsigned long);

      // get/set word position in sentence
      void set_position(size_t);
      size_t get_position() const;

      /// look for an analysis with a tag matching given regexp
      bool find_tag_match(freeling::regexp &);

      /// get number of analysis in current list
      int get_n_analysis() const;
      /// empty the list of selected analysis
      void unselect_all_analysis(int k=0);
      /// mark all analysisi as selected
      void select_all_analysis(int k=0);
      /// add the given analysis to selected list.
      void select_analysis(word::iterator, int k=0);
      /// remove the given analysis from selected list.
      void unselect_analysis(word::iterator, int k=0);
      /// get list of analysis (useful for perl API)
      std::list<freeling::analysis> get_analysis() const;
      /// get begin iterator to analysis list (useful for perl/java API)
      word::iterator analysis_begin();
      /// get end iterator to analysis list (useful for perl/java API)
      word::iterator analysis_end();
      #ifndef FL_API_JAVA
      /// get begin iterator to analysis list (useful for perl/java API)
      word::const_iterator analysis_begin() const;
      /// get end iterator to analysis list (useful for perl/java API)
      word::const_iterator analysis_end() const;
      #endif
};

////////////////////////////////////////////////////////////////
///   Class parse tree is used to store the results of parsing
///  Each node in the tree is either a label (intermediate node)
///  or a word (leaf node)
////////////////////////////////////////////////////////////////

class node {
  public:
    /// constructors
    node();
    node(const std::wstring &);
    ~node();

    /// get node identifier
    std::wstring get_node_id() const;
    /// set node identifier
    void set_node_id(const std::wstring &);
    /// get node label
    std::wstring get_label() const;
    /// find out whether the node has an associated word
    bool has_word() const;
    /// get node word
    word & get_word();
    #ifndef FL_API_JAVA
    const word & get_word() const;
    #endif
    /// set node label
    void set_label(const std::wstring &);
    /// set node word
    void set_word(word &);
    /// find out whether node is a head
    bool is_head() const;
    /// set whether node is a head
    void set_head(const bool);
    /// find out whether node is a chunk
    bool is_chunk() const;
    /// set position of the chunk in the sentence
    void set_chunk(const int);
    /// get position of the chunk in the sentence
    int  get_chunk_ord() const;
};

////////////////////////////////////////////////////////////////
/// class parse_tree stores a constituent tree
////////////////////////////////////////////////////////////////

class parse_tree : public tree<freeling::node> {
  public:
    parse_tree();
    parse_tree(parse_tree::iterator p);
    parse_tree(const node &);

    /// assign an id to each node and build index
    void build_node_index(const std::wstring &);
    /// rebuild index maintaining node id's
    void rebuild_node_index();
    /// access the node with given id
    parse_tree::iterator get_node_by_id(const std::wstring &);
    /// access the node by word position
    parse_tree::iterator get_node_by_pos(size_t);

    #ifndef FL_API_JAVA
     /// access the node with given id
     parse_tree::const_iterator get_node_by_id(const std::wstring &) const;
     /// access the node by word position
     parse_tree::const_iterator get_node_by_pos(size_t) const;
    #endif

   /// obtain a reference to head word of a parse_tree
    static const word& get_head_word(parse_tree::const_iterator);
    /// obtain position of head word of a parse_tree (or -1 if no head)
    static int get_head_position(parse_tree::const_iterator pt);

    /// print a parse tree (debugging purposes mainly)
    static void PrintTree(parse_tree::const_iterator n, int k, int depth);

    /// C-commands
    ///    1 - pt1 does not dominate pt2
    ///    2 - pt2 does not dominate pt1
    ///    3 - The first branching node that dominates pt1 also dominates pt2
    static bool C_commands(parse_tree::const_iterator, parse_tree::const_iterator);

    // explicit inheritance from tree<node>, to help SWIG
    parse_tree& nth_child_ref(unsigned int);
       
};


////////////////////////////////////////////////////////////////
/// class denode stores nodes of a dependency tree and
///  parse tree <-> deptree relations
////////////////////////////////////////////////////////////////

class depnode : public node {
  public:
    depnode();
    depnode(const std::wstring &);
    depnode(const node &);
    ~depnode();

    void set_link(const parse_tree::iterator);
    parse_tree::iterator get_link(void);
    #ifndef FL_API_JAVA
    parse_tree::const_iterator get_link(void) const;
    #endif
  
};

////////////////////////////////////////////////////////////////
/// class dep_tree stores a dependency tree
////////////////////////////////////////////////////////////////

class dep_tree :  public tree<freeling::depnode> {
  public:
    dep_tree();
    dep_tree(const depnode &);

    /// get depnode corresponding to word in given position
    dep_tree::iterator get_node_by_pos(size_t);
    #ifndef FL_API_JAVA
    /// get depnode corresponding to word in given position
    dep_tree::const_iterator get_node_by_pos(size_t) const;
    #endif
    /// rebuild index maintaining words positions
    void rebuild_node_index();

    /// obtain position of the first/last word of the sequence 
    /// subsumed by a depnode.
    static size_t get_first_word(dep_tree::const_iterator);
    static size_t get_last_word(dep_tree::const_iterator);

    /// print a dependency tree (debugging purposes mainly)
    static void PrintDepTree(dep_tree::const_iterator n, int depth);
    
    // explicit inheritance from tree<depnode>, to help SWIG
    dep_tree& nth_child_ref(unsigned int);
};


  ////////////////////////////////////////////////////////////////
  ///   Class argument stores information about a predicate argument
  ////////////////////////////////////////////////////////////////

  class argument  {
    public:
      static const std::wstring EMPTY_ROLE;

      argument();
      ~argument();
      argument(int p, const std::wstring &r);
      
      /// getters
      int get_position() const;
      std::wstring get_role() const;
  };

  ////////////////////////////////////////////////////////////////
  ///   Class predicate stores a predicate and its arguments
  ////////////////////////////////////////////////////////////////

  class predicate : public std::vector<argument> {

    public:
      predicate();
      ~predicate();
      predicate(int p, const std::wstring &s);
      /// Copy constructor
      predicate(const predicate &);
      /// assignment
      predicate& operator=(const predicate&);

      /// get the propbank sense of the predicate
      std::wstring get_sense() const;
      /// get the position of the predicate head
      int get_position() const;
      /// check whether word in position p is an argument to the predicate
      bool has_argument(int p) const;
      /// add new argument to the predicate
      void add_argument(int p, const std::wstring &r);
      /// get access to an argument by word position
      const argument & get_argument_by_pos(int p) const;
  };

////////////////////////////////////////////////////////////////
///   Class sentence is just a list of words that someone
/// (the splitter) has validated it as a complete sentence.
/// It may include a parse tree.
////////////////////////////////////////////////////////////////

class sentence : public std::list<freeling::word> {
 public:
  typedef std::vector<predicate> predicates;

  sentence();
  sentence(const std::list<freeling::word>&);
  /// Copy constructor
  sentence(const sentence &);
  /// assignment
  sentence& operator=(const sentence&);
  // destructor
  ~sentence();

  /// find out how many kbest sequences the tagger computed
  unsigned int num_kbest() const;
  /// add a word to the sentence
  void push_back(const word &);
  /// rebuild word positional index
  void rebuild_word_index();
  // empty sentence
  void clear();

  // get/set sentence id
  void set_sentence_id(const std::wstring &);
  std::wstring get_sentence_id();

  void set_is_tagged(bool);
  bool is_tagged() const;

  /// best tag sequence (Zero by default, unless the user changes it)
  void set_best_seq(int k);
  int get_best_seq() const;
  
  void set_parse_tree(const parse_tree &, int k=0);
  parse_tree & get_parse_tree(int k=0);
  #ifndef FL_API_JAVA
  const parse_tree & get_parse_tree(int k=0) const;
  #endif
  bool is_parsed() const;  

  void set_dep_tree(const dep_tree &, int k=0);
  dep_tree & get_dep_tree(int k=0);
  #ifndef FL_API_JAVA
  const dep_tree & get_dep_tree(int k=0) const;
  #endif
  bool is_dep_parsed() const;

  /// get word list (useful for perl API)
  std::vector<freeling::word> get_words() const;
  /// get iterators to word list (useful for perl/java API)
  sentence::iterator words_begin(void);
  sentence::iterator words_end(void);
  word& operator[](size_t);

  #ifndef FL_API_JAVA
  sentence::const_iterator words_begin(void) const;
  sentence::const_iterator words_end(void) const;
  sentence::const_iterator get_word_iterator(const word &w) const;
  const word& operator[](size_t) const;
  #endif

  sentence::iterator get_word_iterator(const word &w);

  //// SRL 
  void add_predicate(const predicate &pr);
  /// see if word in given position is a predicate
  bool is_predicate(int p) const;
  /// get predicate number n for word in position p
  int get_predicate_number(int p) const;
  /// get word position for predicate number n
  int get_predicate_position(int n) const;
  /// get predicate for word at position p
  const predicate& get_predicate_by_pos(int n) const;
  /// get predicate number n
  const predicate& get_predicate_by_number(int n) const;
  /// get predicates of the sentence (e.g. to iterate over them)
  const predicates & get_predicates() const;

};

////////////////////////////////////////////////////////////////
///   Class paragraph is just a list of sentences that someone
///  has validated it as a paragraph.
////////////////////////////////////////////////////////////////

class paragraph : public std::list<freeling::sentence> {
 public:
  paragraph();
  paragraph(const std::list<freeling::sentence> &x);
  void set_paragraph_id(const std::wstring &);
  std::wstring get_paragraph_id() const;
};


  //////////////////////////////////////////////////////////////////            
  /// Class mention is a node in the parse tree, as well as the sequence of tokens
  /// subsumed by the node.
  /// (It is assumed that a depnode corresponds to a parse tree node)
  //////////////////////////////////////////////////////////////////           
  
  class mention {

  public:
    typedef enum {PROPER_NOUN, PRONOUN, NOUN_PHRASE, COMPOSITE, VERB_PHRASE} mentionType;
    // NE type NOTPER is the supertype of ORG, GEO and OTHER
    typedef enum {PER, MALE, FEMALE, NOTPER, ORG, GEO, OTHER} SEMmentionType;

    /// constructor from a parse_tree
    mention(int, int, paragraph::const_iterator, parse_tree::const_iterator, int, sentence::const_iterator);
    /// constructor from start/end word iterators
    mention(int, int, paragraph::const_iterator, sentence::const_iterator, sentence::const_iterator);
    /// Copy constructor
    mention(const mention &);
    /// assignment
    mention& operator=(const mention&);

    /// True when the mention starts before m in the document
    bool operator<(const mention &m) const;

    /// setters
    void set_id(int);
    void set_type(mentionType);
    void set_initial(bool);
    void set_group(int);
    void set_maximal(bool b);

    /// getters
    int get_id() const;
    int get_n_sentence() const;
    paragraph::const_iterator get_sentence() const;
    int get_pos_begin() const;
    int get_pos_end() const;
    sentence::const_iterator get_it_begin() const;
    sentence::const_iterator get_it_end() const;
    sentence::const_iterator get_it_head() const;
    mentionType get_type() const;
    int get_group() const;
    bool is_type(mentionType) const;
    bool is_initial() const;
    bool is_maximal() const;
    parse_tree::const_iterator get_ptree() const;
    const word& get_head() const;
    std::wstring value() const;    
  };


  namespace semgraph {
    //////////////////////////////////////
    /// Auxiliary class to store mentions to entities found in text
    
    class SG_mention {
    public:
      SG_mention(const std::wstring &mid, const std::wstring &sid, const std::list<std::wstring> &wds);
      ~SG_mention();
      std::wstring get_id() const;
      std::wstring get_sentence_id() const;
      const std::list<std::wstring> & get_words() const;
    };
    
    //////////////////////////////////////
    /// Auxiliary class to store entities found in text (maybe mentioned several times)
    
    typedef enum {ENTITY,WORD} entityType;
    
    class SG_entity {  
    public:
      SG_entity(const std::wstring &elemma,
                const std::wstring &eclass, 
                entityType type, 
                const std::wstring &sense);
      ~SG_entity();
      
      void set_lemma(const std::wstring &lem);
      std::wstring get_id() const;
      std::wstring get_lemma() const;
      std::wstring get_semclass() const;
      entityType get_type() const;
      std::wstring get_sense() const;
      const std::vector<SG_mention> &get_mentions() const;
    };
    
    //////////////////////////////////////
    /// Auxiliary class to store frame arguments
    
    class SG_argument {
    public:
      SG_argument(const std::wstring &r, const std::wstring &e);
      ~SG_argument();
      
      std::wstring get_role() const;
      std::wstring get_entity() const;
    };
    
    //////////////////////////////////////
    /// Auxiliary class to store frames (relations between n entities)
    
    class SG_frame {
    public:
      // constructor
      SG_frame(const std::wstring &lem, const std::wstring &sns, const std::wstring &tk, const std::wstring &sid);
      ~SG_frame();
      
      std::wstring get_id() const;
      std::wstring get_lemma() const;
      std::wstring get_sense() const;
      std::wstring get_token_id() const;
      std::wstring get_sentence_id() const;
      const std::vector<SG_argument> &get_arguments() const;
    };
    
    //////////////////////////////////////
    /// Auxiliary class to store a semantic graph
    
    class semantic_graph {
      
    public:
      semantic_graph();
      ~semantic_graph();
      
      std::wstring add_entity(SG_entity &ent);
      std::wstring add_frame(SG_frame &fr);

      #ifndef FL_API_JAVA
       const SG_frame & get_frame(const std::wstring &fid) const;
       const SG_entity & get_entity(const std::wstring &eid) const;
       const std::vector<SG_entity> & get_entities() const;
       const std::vector<SG_frame> & get_frames() const;
      #endif
 
      SG_frame & get_frame(const std::wstring &fid);
      
      std::wstring get_entity_id_by_mention(const std::wstring &sid,const std::wstring &wid) const;
      std::wstring get_entity_id_by_lemma(const std::wstring &lemma,const std::wstring &sens) const;
      SG_entity & get_entity(const std::wstring &eid);
      
      std::vector<SG_entity> & get_entities();     
      std::vector<SG_frame> & get_frames();
      
      void add_mention_to_entity(const std::wstring &eid, const SG_mention &m);
      void add_argument_to_frame(const std::wstring &fid, const std::wstring &role, const std::wstring &eid);
      
      bool is_argument(const std::wstring &eid) const;     
      bool has_arguments(const std::wstring &fid) const;
      
      bool empty() const;
    };

  }

  ////////////////////////////////////////////////////////////////
  ///   Class document is a list of paragraphs. It may have additional
  ///  information (such as title)
  ////////////////////////////////////////////////////////////////

  class document : public std::list<paragraph> {

  public:
    document();
    /// Copy constructor
    document(const document &);
    /// assignment
    document& operator=(const document&);

    bool is_parsed() const;
    bool is_dep_parsed() const;

    /// Adds one mention to the doc (the mention is already included in a group of coreferents)
    void add_mention(const mention &m);

    // count number of words in the document
    int get_num_words() const;

    /// Gets the number of groups found
    int get_num_groups() const;
    /// get list of ids of existing groups
    const std::list<int> & get_groups() const;

    /// Gets an iterator pointing to the beginning of the mentions 
    std::vector<mention>::iterator begin_mentions();
    /// Gets an iterator pointing to the end of the mentions 
    std::vector<mention>::iterator end_mentions();

    #ifndef FL_API_JAVA
     std::vector<mention>::const_iterator begin_mentions() const;
     std::vector<mention>::const_iterator end_mentions() const;
     const semgraph::semantic_graph & get_semantic_graph() const;
    #endif

    semgraph::semantic_graph & get_semantic_graph();

    /// get reference to i-th mention
    const mention& get_mention(int) const;

    /// Gets all the nodes in a coreference group
    ///std::list<int> get_coref_nodes(int) const;

    /// Gets all the mentions' ids in the ith coreference group found
    std::list<int> get_coref_id_mentions(int) const;

    /// Returns if two nodes are in the same coreference group
    /// bool is_coref(const std::wstring &, const std::wstring &) const;

  };



////////////////  FREELING ANALYSIS MODULES  ///////////////////

/*------------------------------------------------------------------------*/
// codes for input-output formats
typedef enum {TEXT,TOKEN,SPLITTED,MORFO,TAGGED,SENSES,SHALLOW,PARSED,DEP,SRL,COREF,SEMGRAPH} AnalysisLevel;
// codes for tagging algorithms
typedef enum {NO_TAGGER,HMM,RELAX} TaggerAlgorithm;
// codes for dependency parsers
typedef enum {NO_DEP,TXALA,TREELER,LSTM} DependencyParser;
// codes for SRL parsers
typedef enum {NO_SRL,SRL_TREELER} SRLParser;
// codes for sense annotation
typedef enum {NO_WSD,ALL,MFS,UKB} WSDAlgorithm;
// codes for ForceSelect
typedef enum {NO_FORCE,TAGGER,RETOK} ForceSelectStrategy;

// error status for analyzer_config class
typedef enum {CFG_OK, CFG_WARNING, CFG_ERROR} CFG_status;


 
////////////////////////////////////////////////////////////////
/// 
///  Class analyzer::config_options contains the configuration options
///  that define which modules are active and which configuration files
///  are loaded for each of them at construction time.
///  Options in this set can not be altered once the analyzer is created.  
///
////////////////////////////////////////////////////////////////
 
 class analyzer_config_options {
 public:
   /// Language of text to process
   std::wstring Lang;
   /// Tokenizer configuration file
   std::wstring TOK_TokenizerFile;
   /// Splitter configuration file
   std::wstring SPLIT_SplitterFile;
   /// Morphological analyzer options
   std::wstring MACO_Decimal, MACO_Thousand;
   std::wstring MACO_UserMapFile, MACO_LocutionsFile,   MACO_QuantitiesFile,
     MACO_AffixFile,   MACO_ProbabilityFile, MACO_DictionaryFile, 
     MACO_NPDataFile,  MACO_PunctuationFile, MACO_CompoundFile;
   bool MACO_InverseDictionary;
   double MACO_ProbabilityThreshold;
   /// Phonetics config file
   std::wstring PHON_PhoneticsFile;
   /// NEC config file
   std::wstring NEC_NECFile;
   /// Sense annotator and WSD config files
   std::wstring SENSE_ConfigFile;
   std::wstring UKB_ConfigFile;
   /// Tagger options
   std::wstring TAGGER_HMMFile;
   std::wstring TAGGER_RelaxFile;
   int TAGGER_RelaxMaxIter;
   double TAGGER_RelaxScaleFactor;
   double TAGGER_RelaxEpsilon;
   /// Chart parser config file
   std::wstring PARSER_GrammarFile;
   /// Dependency parsers config files
   std::wstring DEP_TxalaFile;   
   std::wstring DEP_TreelerFile;   
   std::wstring DEP_LSTMFile;
   /// Semantic role labeling files
   std::wstring SRL_TreelerFile;
   /// Coreference resolution config file
   std::wstring COREF_CorefFile;
   /// semantic graph extractor config file
   std::wstring SEMGRAPH_SemGraphFile;
 };
 
 ////////////////////////////////////////////////////////////////
 /// 
 ///  Class analyzer::invoke_options contains the options
 ///  that define the behaviour of each module in the analyze 
 ///  on the next analysis.
 ///  Options in this set can be altered after construction
 ///  (e.g. to activate/deactivate certain modules)
 ///
 ////////////////////////////////////////////////////////////////
 
 class analyzer_invoke_options {
 public:
   /// Level of analysis in input and output
   AnalysisLevel InputLevel, OutputLevel;
   
   /// activate/deactivate morphological analyzer modules
   bool MACO_UserMap, MACO_AffixAnalysis, MACO_MultiwordsDetection, 
     MACO_NumbersDetection, MACO_PunctuationDetection, 
     MACO_DatesDetection, MACO_QuantitiesDetection, 
     MACO_DictionarySearch, MACO_ProbabilityAssignment, MACO_CompoundAnalysis,
     MACO_NERecognition, MACO_RetokContractions;
   
   /// activate/deactivate phonetics and NEC
   bool PHON_Phonetics;
   bool NEC_NEClassification;

   /// tagger options
   bool TAGGER_Retokenize;
   ForceSelectStrategy TAGGER_ForceSelect;
   int TAGGER_kbest;
   
   /// Select which tagger, parser, or sense annotator to use
   WSDAlgorithm SENSE_WSD_which;
   TaggerAlgorithm TAGGER_which;
   DependencyParser DEP_which;    
   SRLParser SRL_which;
 };


 ////////////////////////////////////////////////////////////////
 ///  class to handle configuration error states

 class status {
 public:
   CFG_status stat;
   std::wstring description;
 };

 class analyzer_config {
 public:

   analyzer_config_options config_opt;
   analyzer_invoke_options invoke_opt;

   /// constructor
   analyzer_config();
   /// destructor
   ~analyzer_config();

   // access to options description, in case user wants to add some.
   po::options_description& command_line_options();
   po::options_description& config_file_options();

   /// load options from a config file, ignore variables map
   void parse_options(const std::wstring &cfgFile);
   /// load options from a config file, update variables map
   void parse_options(const std::wstring &cfgFile, po::variables_map &vm);
   /// load options from command line, ignore variables map   
   void parse_options(int ac, char *av[]);   
   /// load options from command line, update variables map 
   void parse_options(int ac, char *av[], po::variables_map &vm);   
   /// load options from a config file + command line, ignore variables map   
   void parse_options(const std::wstring &cfgFile, int ac, char *av[]);   
   /// load options from a config file + command line, update variables map
   void parse_options(const std::wstring &cfgFile, int ac, char *av[], po::variables_map &vm);   

   // check invoke options
   status check_invoke_options(const analyzer_invoke_options &opt) const; 

 };
 
 
 //%nestedworkaround analyzer_config_options;
 //%nestedworkaround analyzer_invoke_options;
 %{
  namespace freeling {
    //typedef freeling::analyzer_config_options config_options;
    //typedef freeling::analyzer_invoke_options invoke_options;
   typedef freeling::analyzer_config::status status;
  }
  %}

////////////////////////////////////////////////////////////////
/// 
///  Class analyzer is a meta class that just calls all modules in
///  FreeLing in the right order.
///  Its construction options allow to instantiate different kinds of
///  analysis pipelines, and or different languages.
///  Also, invocation options may be altered at each call, 
///  tuning the analysis to each particular sentence or document needs.
///  For a finer control, underlying modules should be called directly.
///
////////////////////////////////////////////////////////////////

class analyzer {

 public:
   analyzer(const analyzer_config &cfg);
   analyzer(const analyzer_config_options &cfg);

   ~analyzer();

   /// analyze further levels on a partially analyzed document
   void analyze(document &doc) const;
   void analyze(document &doc, const analyzer_invoke_options &ivk) const;
   /// analyze further levels on partially analyzed sentences
   void analyze(std::list<sentence> &ls) const;
   void analyze(std::list<sentence> &ls, const analyzer_invoke_options &ivk) const;
   /// analyze text as a whole document
   void analyze(const std::wstring &text, document &doc, bool parag=false) const;
   void analyze(const std::wstring &text, document &doc, const analyzer_invoke_options &ivk, bool parag=false) const;
   /// analyze text as a whole document, returning it (useful for python API)
   document analyze_as_document(const std::wstring &text, bool parag=false) const;
   document analyze_as_document(const std::wstring &text, const analyzer_invoke_options &ivk, bool parag=false) const;
  /// Analyze text as a partial document. Retain incomplete sentences in buffer   
   /// in case next call completes them (except if flush==true)
   void analyze(const std::wstring &text, std::list<sentence> &ls, bool flush=false);
   void analyze(const std::wstring &text, std::list<sentence> &ls, const analyzer_invoke_options &ivk, bool flush=false);
   /// Analyze text as a partial document. Retain incomplete sentences in buffer. Return analysis (useful for python API)
   std::list<sentence> analyze(const std::wstring &text, bool flush=false);
   std::list<sentence> analyze(const std::wstring &text, const analyzer_invoke_options &ivk, bool flush=false);

   // flush splitter buffer and analyze any pending text. 
   void flush_buffer(std::list<sentence> &ls);
   void flush_buffer(std::list<sentence> &ls, const analyzer_invoke_options &ivk);
   // reset tokenizer offset counter
   void reset_offset();

};


/*------------------------------------------------------------------------*/
class traces {
 public:
    // current trace level
    static int TraceLevel;
    // modules to trace
    static unsigned long long TraceModule;
    #if !defined(FL_API_JAVA)
    %extend {
      void set_trace_level(int l) { $self->TraceLevel = l; }
      void set_trace_module(unsigned long long m) { $self->TraceModule = m; }
    }
    #endif
};


/*------------------------------------------------------------------------*/
class lang_ident {
   public:
      /// constructor
      lang_ident();
      lang_ident (const std::wstring &);
      ~lang_ident();

      void add_language(const std::wstring&);
      /// train a model for a language, store in modelFile, and add 
      /// it to the known languages list.
      void train_language(const std::wstring &, const std::wstring &, const std::wstring &, size_t order);

      /// Identify language, return most likely language for given text,
      /// consider only languages in given set (empty --> all available languages)
      std::wstring identify_language(const std::wstring &, 
      				     const std::set<std::wstring> &ls=std::set<std::wstring>()) const;
      /// Identify language, return list of pairs<probability,language> 
      /// sorted by decreasing probability. Consider only languages
      /// in given set (empty --> all available languages).
      void rank_languages(std::vector<std::pair<double,std::wstring> > &, 
      			  const std::wstring &, 
      			  const std::set<std::wstring> &ls=std::set<std::wstring>()) const;
      std::vector<std::pair<double,std::wstring> > rank_languages (const std::wstring &text,
                                                                   const std::set<std::wstring> &ls=std::set<std::wstring>()) const;

};


/*------------------------------------------------------------------------*/
class tokenizer {
   public:
       /// Constructor
       tokenizer(const std::wstring &);
       ~tokenizer();

       /// tokenize wstring 
       std::list<freeling::word> tokenize(const std::wstring &) const;
       /// tokenize string, tracking offset
       std::list<freeling::word> tokenize(const std::wstring &, unsigned long &) const;
};


/*------------------------------------------------------------------------*/
class splitter {

   public:
     /// Constructor
     splitter(const std::wstring &);
     /// Destructor
     ~splitter();

     typedef splitter_status* session_id;
     /// open a splitting session
     session_id open_session() const ;
     /// close splitting session
     void close_session(session_id) const;

     /// split sentences
     std::list<sentence> split(session_id, const std::list<word> &, bool) const;
     // sessionless splitting.  
     // Equivalent to opening a session, split with flush=true, and close the session
     std::list<sentence> split(const std::list<word> &) const;

};


/*------------------------------------------------------------------------*/
class processor {
  public:
    /// constructor
    processor() {};
    /// destructor
    virtual ~processor() {};

     #if defined(FL_API_JAVA)
     /// analyze sentence
     virtual void analyze(sentence &s) const = 0;
     /// analyze list of sentences
     virtual void analyze(std::list<freeling::sentence> &) const;
     /// analyze document
     virtual void analyze(document &) const;
     /// analyze sentence with given options
     virtual void analyze(sentence &s, const analyzer_invoke_options &opts) const;
     /// analyze list of sentences (paragraph) with given options
     virtual void analyze(std::list<freeling::sentence> &ls, const analyzer_invoke_options &opts) const;
     /// analyze document with given options
     virtual void analyze(document &doc, const analyzer_invoke_options &opts) const;

     #else
     /// analyze sentence, return copy
     %rename(analyze_sentence) analyze;
     virtual sentence analyze(const sentence &s) const = 0;
     /// analyze sentences, return copy
     %rename(analyze_sentence_list) analyze;
     virtual std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
     /// analyze document, return copy
     %rename(analyze_document) analyze;
     virtual document analyze(const document &d) const;
     %rename(analyze) analyze;
     #endif


};
 
/*------------------------------------------------------------------------*/
 class maco : public processor {
   public:
     /// Constructor
     maco(const analyzer_config &); 
     /// Destructor
     ~maco();

    /// convenience:  retrieve options used at creation time (e.g. to reset current config)
    const analyzer_config& get_initial_options() const;
    /// set configuration to be used by default
    void set_current_invoke_options(const analyzer_invoke_options &opt);
    /// get configuration being used by default
    const analyzer_invoke_options& get_current_invoke_options() const;
    /// alternative for set_current_invoke_options
    void set_active_options(bool umap, bool num, bool pun, bool dat,
                            bool dic, bool aff, bool comp, bool rtk,
                            bool mw, bool ner, bool qt, bool prb); 
     #if defined(FL_API_JAVA)
     /// analyze sentence
     void analyze(sentence &s) const;
     /// analyze list of sentences
     void analyze(std::list<freeling::sentence> &) const;
     /// analyze document
     void analyze(document &) const;
     /// analyze sentence with given options
     void analyze(sentence &s, const analyzer_invoke_options &opts) const;
     /// analyze list of sentences (paragraph) with given options
     void analyze(std::list<freeling::sentence> &ls, const analyzer_invoke_options &opts) const;
     /// analyze document with given options
     void analyze(document &doc, const analyzer_invoke_options &opts) const;

     #else
     /// analyze sentence, return copy
     %rename(analyze_sentence) analyze;
     sentence analyze(const sentence &s) const;
     /// analyze sentences, return copy
     %rename(analyze_sentence_list) analyze;
     std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
     /// analyze document, return copy
     %rename(analyze_document) analyze;
     document analyze(const document &d) const;
     %rename(analyze) analyze;
     #endif
};


 

/*------------------------------------------------------------------------*/
 class RE_map : public processor {
    
 public:
  /// Constructor (config file)
  RE_map(const std::wstring &); 
  ~RE_map();

  /// annotate given word
  void annotate_word(word &) const;

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/
class numbers {
  public:
    // constructor: language (en), decimal (.), thousands (,)
    numbers(const std::wstring &, const std::wstring &, const std::wstring &);
    ~numbers();

    #if defined(FL_API_JAVA)
    /// analyze sentence
    void analyze(sentence &) const;
    /// analyze sentences
    void analyze(std::list<freeling::sentence> &) const;
    /// analyze document
    void analyze(document &) const;
    #else
    /// analyze sentence, return copy
    %rename(analyze_sentence) analyze;
    sentence analyze(const sentence &s) const;
    /// analyze sentences, return copy
    %rename(analyze_sentence_list) analyze;
    std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
    /// analyze document, return copy
    %rename(analyze_document) analyze;
    document analyze(const document &d) const;
    %rename(analyze) analyze;
    #endif
};


/*------------------------------------------------------------------------*/
class punts : public processor {
 public:
  /// Constructor (config file)
  punts(const std::wstring &); 
  ~punts();

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/ 
class dates {
 public:   
  /// Constructor (config file)
  dates(const std::wstring &); 
  /// Destructor
  ~dates(); 

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};  

/*------------------------------------------------------------------------*/
class dictionary : public processor {
 public:
    /// Constructor
    dictionary(const analyzer_config &opts);
    /// Destructor
    ~dictionary();

    /// convenience:  retrieve options used at creation time (e.g. to reset current config)
    const analyzer_config& get_initial_options() const;
    /// set configuration to be used by default
    void set_current_invoke_options(const analyzer_invoke_options &opt);
    /// get configuration being used by default
    const analyzer_invoke_options& get_current_invoke_options() const;

    /// add analysis to dictionary entry (create entry if not there)
    void add_analysis(const std::wstring &, const analysis &);
    /// remove entry from dictionary
    void remove_entry(const std::wstring &);

    /// Get dictionary entry for a given form, add to given list.
    void search_form(const std::wstring &, std::list<analysis> &) const;
    /// Fills the analysis list of a word, checking for suffixes and contractions.
    /// Returns true iff the form is a contraction, returns contraction components
    /// in given list
    bool annotate_word(word &, std::list<word> &, const analyzer_invoke_options &opts) const;
    /// annotate word with default options
    bool annotate_word(word &, std::list<word> &) const;
    /// Fills the analysis list of a word, checking for suffixes and contractions.
    /// Never retokenizing contractions, nor returning component list.
    /// It is just a convenience equivalent to "annotate_word(w,dummy,opts)
    /// with opts.retokenize=opts.compound=false"
    void annotate_word(word &) const;
    /// Get possible forms for a lemma+pos
    std::list<std::wstring> get_forms(const std::wstring &, const std::wstring &) const;

     #if defined(FL_API_JAVA)
     /// analyze sentence
     void analyze(sentence &s) const;
     /// analyze sentence with given options
     void analyze(sentence &s, const analyzer_invoke_options &opts) const;
     /// analyze list of sentences
     void analyze(std::list<freeling::sentence> &) const;
     /// analyze list of sentences (paragraph) with given options
     void analyze(std::list<freeling::sentence> &ls, const analyzer_invoke_options &opts) const;
     /// analyze document
     void analyze(document &) const;
     /// analyze document with given options
     void analyze(document &doc, const analyzer_invoke_options &opts) const;
     #else
     /// analyze sentence, return copy
     %rename(analyze_sentence) analyze;
     sentence analyze(const sentence &s) const;
     /// analyze sentences, return copy
     %rename(analyze_sentence_list) analyze;
     std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
     /// analyze document, return copy
     %rename(analyze_document) analyze;
     document analyze(const document &d) const;
     %rename(analyze) analyze;
     #endif

};

/*------------------------------------------------------------------------*/
class locutions {
 public:
  /// Constructor (config file)
  locutions(const std::wstring &);
  ~locutions();
  void add_locution(const std::wstring &);
  void set_OnlySelected(bool);

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/
class ner {
 public:
  /// Constructor (config file)
  ner(const std::wstring &);
  /// Destructor
  ~ner();

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/
class crf_nerc {
  
  public:
    /// Constructor
    crf_nerc(const std::wstring &);
    /// Destructor
    ~crf_nerc();

    #if defined(FL_API_JAVA)
    /// analyze sentence
    void analyze(sentence &) const;
    /// analyze sentences
    void analyze(std::list<freeling::sentence> &) const;
    /// analyze document
    void analyze(document &) const;
    #else
    /// analyze sentence, return copy
    %rename(analyze_sentence) analyze;
    sentence analyze(const sentence &s) const;
    /// analyze sentences, return copy
    %rename(analyze_sentence_list) analyze;
    std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
    /// analyze document, return copy
    %rename(analyze_document) analyze;
    document analyze(const document &d) const;
    %rename(analyze) analyze;
    #endif
};

 
/*------------------------------------------------------------------------*/
class quantities {
 public:
  /// Constructor (language, config file)
  quantities(const std::wstring &, const std::wstring &); 
  /// Destructor
  ~quantities(); 

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/
class probabilities : public processor {
 public:
  /// Constructor (language, config file, threshold)
  probabilities(const std::wstring &, double);
  ~probabilities();

  /// Assign probabilities for each analysis of given word
  void annotate_word(word &) const;
  /// Turn guesser on/of
  void set_activate_guesser(bool);

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/
class hmm_tagger {
 public:
  /// Constructor
  hmm_tagger(const analyzer_config &opt);
  ~hmm_tagger();

  /// Given an *annotated* sentence, compute (log) probability of k-th best
  /// sequence according to HMM parameters.
  double SequenceProb_log(const sentence &, int k=0) const;

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};


/*------------------------------------------------------------------------*/
class relax_tagger {
 public:
  /// Constructor, given the constraints file and config parameters
  relax_tagger(const analyzer_config &opt);
  ~relax_tagger();

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};


/*------------------------------------------------------------------------*/
  class alternatives : public processor {

  public:
    /// Constructor
    alternatives(const std::wstring &);
    /// Destructor
    ~alternatives();

    /// direct access to results of underlying automata
    void get_similar_words(const std::wstring &, std::list<freeling::alternative> &) const;

    #if defined(FL_API_JAVA)
    /// analyze sentence
    void analyze(sentence &) const;
    /// analyze sentences
    void analyze(std::list<freeling::sentence> &) const;
    /// analyze document
    void analyze(document &) const;
    #else
    /// analyze sentence, return copy
    %rename(analyze_sentence) analyze;
    sentence analyze(const sentence &s) const;
    /// analyze sentences, return copy
    %rename(analyze_sentence_list) analyze;
    std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
    /// analyze document, return copy
    %rename(analyze_document) analyze;
    document analyze(const document &d) const;
    %rename(analyze) analyze;
    #endif

  };



/*------------------------------------------------------------------------*/
class phonetics : public processor {  
 public:
  /// Constructor, given config file
  phonetics(const std::wstring&);
  ~phonetics();
  
  /// Returns the phonetic sound of the word
  std::wstring get_sound(const std::wstring &) const;

  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};

/*------------------------------------------------------------------------*/
class nec : public processor {
 public:
  /// Constructor
  nec(const std::wstring &); 
  /// Destructor
  ~nec();
  
  #if defined(FL_API_JAVA)
  /// analyze sentence
  void analyze(sentence &) const;
  /// analyze sentences
  void analyze(std::list<freeling::sentence> &) const;
  /// analyze document
  void analyze(document &) const;
  #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
  #endif
};


/*------------------------------------------------------------------------*/
class chart_parser : public processor {
 public:
   /// Constructors
   chart_parser(const std::wstring&);
   ~chart_parser();

   /// Get the start symbol of the grammar
   std::wstring get_start_symbol(void) const;

   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
  /// analyze sentence, return copy
  %rename(analyze_sentence) analyze;
  sentence analyze(const sentence &s) const;
  /// analyze sentences, return copy
  %rename(analyze_sentence_list) analyze;
  std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
  /// analyze document, return copy
  %rename(analyze_document) analyze;
  document analyze(const document &d) const;
  %rename(analyze) analyze;
   #endif
};


/*------------------------------------------------------------------------*/
class dep_txala {
 public:   
   dep_txala(const std::wstring &, const std::wstring &);
   ~dep_txala();

   /// apply completion rules to get a full parse tree
   void complete_parse_tree(sentence &) const;
   /// apply completion rules to get a full parse tree
   void complete_parse_tree(std::list<sentence> &) const;
   /// apply completion rules to get a full parse tree
   void complete_parse_tree(document &) const;

   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
   /// analyze sentence, return copy
   %rename(analyze_sentence) analyze;
   sentence analyze(const sentence &s) const;
   /// analyze sentences, return copy
   %rename(analyze_sentence_list) analyze;
   std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
   /// analyze document, return copy
   %rename(analyze_document) analyze;
   document analyze(const document &d) const;
   %rename(analyze) analyze;
   #endif

};

/*------------------------------------------------------------------------*/
class dep_treeler {
 public:   
   dep_treeler(const std::wstring &);
   ~dep_treeler();

   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
   /// analyze sentence, return copy
   %rename(analyze_sentence) analyze;
   sentence analyze(const sentence &s) const;
   /// analyze sentences, return copy
   %rename(analyze_sentence_list) analyze;
   std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
   /// analyze document, return copy
   %rename(analyze_document) analyze;
   document analyze(const document &d) const;
   %rename(analyze) analyze;
   #endif
};


/*------------------------------------------------------------------------*/
class dep_lstm {
  
 public:
    /// constructor
    dep_lstm(const std::wstring &fname);
    /// destructor
    ~dep_lstm();
    
   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
   /// analyze sentence, return copy
   %rename(analyze_sentence) analyze;
   sentence analyze(const sentence &s) const;
   /// analyze sentences, return copy
   %rename(analyze_sentence_list) analyze;
   std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
   /// analyze document, return copy
   %rename(analyze_document) analyze;
   document analyze(const document &d) const;
   %rename(analyze) analyze;
   #endif

  };


/*------------------------------------------------------------------------*/

class srl_treeler {

 public:   
  /// Constructor
  srl_treeler(const std::wstring &);
  /// Destructor
  ~srl_treeler();

   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
   /// analyze sentence, return copy
   %rename(analyze_sentence) analyze;
   sentence analyze(const sentence &s) const;
   /// analyze sentences, return copy
   %rename(analyze_sentence_list) analyze;
   std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
   /// analyze document, return copy
   %rename(analyze_document) analyze;
   document analyze(const document &d) const;
   %rename(analyze) analyze;
   #endif
    
};


 
/*------------------------------------------------------------------------*/
class senses : public processor {
 public:
  /// Constructor
  senses(const std::wstring &); 
  /// Destructor
  ~senses(); 
  
   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
   /// analyze sentence, return copy
   %rename(analyze_sentence) analyze;
   sentence analyze(const sentence &s) const;
   /// analyze sentences, return copy
   %rename(analyze_sentence_list) analyze;
   std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
   /// analyze document, return copy
   %rename(analyze_document) analyze;
   document analyze(const document &d) const;
   %rename(analyze) analyze;
   #endif
};


/*------------------------------------------------------------------------*/
class relaxcor {
  public:

    /// Constructor
    relaxcor(const std::wstring &fname);
    /// Destructor
    ~relaxcor();

    // set provide_singletons
    void set_provide_singletons(bool);
    // get provide_singletons
    bool get_provide_singletons() const;
    
    void analyze(document &) const;   
  };

/*------------------------------------------------------------------------*/
 class semgraph_extract {
  public:
    /// Constructor   
    semgraph_extract(const std::wstring &erFile);    
    /// Destructor   
    ~semgraph_extract();
    
    /// extract graph from given document
    void extract(document &doc) const;
 };

/*------------------------------------------------------------------------*/
class ukb {
 public:
  /// Constructor
  ukb(const std::wstring &);
  /// Destructor
  ~ukb();
  
   #if defined(FL_API_JAVA)
   /// analyze sentence
   void analyze(sentence &) const;
   /// analyze sentences
   void analyze(std::list<freeling::sentence> &) const;
   /// analyze document
   void analyze(document &) const;
   #else
   /// analyze sentence, return copy
   %rename(analyze_sentence) analyze;
   sentence analyze(const sentence &s) const;
   /// analyze sentences, return copy
   %rename(analyze_sentence_list) analyze;
   std::list<freeling::sentence> analyze(const std::list<freeling::sentence> &) const;
   /// analyze document, return copy
   %rename(analyze_document) analyze;
   document analyze(const document &d) const;
   %rename(analyze) analyze;
   #endif
};


/*------------------------------------------------------------------------*/
class sense_info {
 public:
  /// sense code
  std::wstring sense;
  /// hyperonyms
  std::list<std::wstring> parents;
  /// WN semantic file code
  std::wstring semfile;
  /// list of synonyms (words in the synset)
  std::list<std::wstring> words;
  /// list of EWN top ontology properties
  std::list<std::wstring> tonto;
  /// Link to SUMO concept
  std::wstring sumo;
  /// Link to CYC concept
  std::wstring cyc;
  
  /// constructor
  sense_info(const std::wstring &,const std::wstring &);
  std::wstring get_parents_string() const;
};


////////////////////////////////////////////////////////////////
/// Class semanticDB implements a semantic DB interface
////////////////////////////////////////////////////////////////

class semanticDB {
 public:
  /// Constructor
  semanticDB(const std::wstring &);
  /// Destructor
  ~semanticDB();
  
  /// Compute list of lemma-pos to search in WN for given word, according to mapping rules.
  void get_WN_keys(const std::wstring &, const std::wstring &, const std::wstring &, std::list<std::pair<std::wstring,std::wstring> > &) const;
  /// get list of words for a sense
  std::list<std::wstring> get_sense_words(const std::wstring &) const;
  /// get list of senses for a lemma+pos
  std::list<std::wstring> get_word_senses(const std::wstring &, const std::wstring &, const std::wstring &) const;
  /// get sense info for a sense
  sense_info get_sense_info(const std::wstring &) const;
};


////////////////////////////////////////////////////////////////
/// EAGLES tagset handler
////////////////////////////////////////////////////////////////

class tagset {

  public:
    /// constructor: load a map file
    tagset(const std::wstring &f);
    /// destructor
    ~tagset();

    /// get short version of given tag
    std::wstring get_short_tag(const std::wstring &tag) const;
    /// get map of <feature,value> pairs with morphological information
    std::map<std::wstring,std::wstring> get_msd_features_map(const std::wstring &tag) const;
    /// get list of <feature,value> pairs with morphological information
    std::list<std::pair<std::wstring,std::wstring> > get_msd_features(const std::wstring &tag) const;
    /// get list <feature,value> pairs with morphological information, in a string format
    std::wstring get_msd_string(const std::wstring &tag) const;
    /// get EAGLES tag from morphological info given as list <feature,value> pairs 
    std::wstring msd_to_tag(const std::wstring &cat,const std::list<std::pair<std::wstring,std::wstring> > &msd) const;
    /// get EAGLES tag from morphological info given as string 
    std::wstring msd_to_tag(const std::wstring &cat,const std::wstring &msd) const;
};

////////////////////////////////////////////////////////////////
/// Wrapper for libfoma FSM

class foma_FSM {

  public:
    /// build regular automaton from text file, optional cost matrix, join chars if it is a compound FSA
    foma_FSM(const std::wstring &, const std::wstring &mcost="", 
             const std::list<std::wstring> &joins=std::list<std::wstring>());
    /// build regular automaton from text buffer, optional cost matrix, join chars if it is a compound FSA
    foma_FSM(std::wistream &, const std::wstring &mcost="", 
             const std::list<std::wstring> &joins=std::list<std::wstring>());
    /// clear 
    ~foma_FSM();

    /// Use automata to obtain closest matches to given form, and add them to given list.
    void get_similar_words(const std::wstring &, std::list<freeling::alternative> &) const;    
    /// set maximum edit distance of desired results
    void set_cutoff_threshold(int);
    /// set maximum number of desired results
    void set_num_matches(int);
    /// Set cost for basic SED operations (insert, delete, substitute)
    void set_basic_operation_cost(int);
    /// Set cost for a particular SED operation (replace "in" with "out")
    void set_operation_cost(const std::wstring &, const std::wstring &, int);
    /// get FSM alphabet
    std::set<std::wstring> get_alphabet();
};


  ////////////////////////////////////////////////////////////////
  ///  Class fex implements a feature extractor.
  ////////////////////////////////////////////////////////////////

  class fex {
  public:
    /// constructor, given rule file, lexicon file (may be empty), and custom functions
    fex(const std::wstring&, 
        const std::wstring&, 
        const std::map<std::wstring,const freeling::feature_function *> &custom=std::map<std::wstring,const freeling::feature_function *>() );
    /// destructor
    ~fex();

    /// encode given sentence in features as feature names. 
    void encode_name(sentence &, std::vector<std::set<std::wstring> > &) const;
    /// encode given sentence in features as integer feature codes
    void encode_int(sentence &, std::vector<std::set<int> > &) const;
    /// encode given sentence in features as integer feature codes and as features names
    void encode_all(sentence &, std::vector<std::set<std::wstring> > &, std::vector<std::set<int> > &) const;

    /// encode given sentence in features as feature names. Return result suitable for Java/perl APIs
    std::vector<std::set<std::wstring> > encode_name(sentence &) const;
    /// encode given sentence in features as integer feature codes. Return result apt for Java/perl APIs
    std::vector<std::set<int> > encode_int(sentence &) const;

    /// clear lexicon
    void clear_lexicon(); 
    /// encode sentence and add features to current lexicon
    void encode_to_lexicon(sentence &);
    /// save lexicon to a file, filtering features with low occurrence rate
    void save_lexicon(const std::wstring &, double) const;
  };

  ////////////////////////////////////////////////////////////////
  ///  Class fex implements a feature lexicon
  ////////////////////////////////////////////////////////////////

  class fex_lexicon  {
    
  public:
    /// constructor: empty lexicon
    fex_lexicon();
    /// constructor: load file
    fex_lexicon(const std::wstring &);
    /// empty lexicon
    void clear_lexicon(); 
    /// add feature occurrence to lexicon
    void add_occurrence(const std::wstring &);
    /// save lexicon to a file, filtering features with low occurrence rate
    void save_lexicon(const std::wstring &, double) const;
    /// consult: get feature code
    unsigned int get_code(const std::wstring &) const;
    /// consult: get feature frequency
    unsigned int get_freq(const std::wstring &) const;
    /// Find out whether the lexicon contains the given feature code
    bool contains_code(unsigned int) const; 
    /// Find out whether the lexicon is loaded and full
    bool is_empty() const; 
  };


////////////////////////////////////////////////////////////////
/// Utilities
////////////////////////////////////////////////////////////////

class util {
 public:
  /// Init the locale of the program, to properly handle unicode
  static void init_locale(const std::wstring &);

  /// conversion utilities
  static int wstring2int(const std::wstring &);
  static std::wstring int2wstring(const int);
  static double wstring2double(const std::wstring &);
  static std::wstring double2wstring(const double);
  static long double wstring2longdouble(const std::wstring &);
  static std::wstring longdouble2wstring(const long double);
  static std::wstring vector2wstring(const std::vector<std::wstring> &, const std::wstring &);
  static std::wstring list2wstring(const std::list<std::wstring> &, const std::wstring &);
  static std::wstring pairlist2wstring(const std::list<std::pair<std::wstring, double> > &, const std::wstring &, const std::wstring &);
  static std::wstring pairlist2wstring(const std::list<std::pair<std::wstring, std::wstring> > &, const std::wstring &, const std::wstring &);
  static std::list<std::wstring> wstring2list(const std::wstring &, const std::wstring &);
  static std::vector<std::wstring> wstring2vector(const std::wstring &, const std::wstring &);
  /// capitalization functions
  static int capitalization(const std::wstring &);
  static std::wstring capitalize(const std::wstring &, int, bool);
  static std::wstring lowercase(const std::wstring &);
  static std::wstring uppercase(const std::wstring &);
};


////////////////////////////////////////////////////////////////
/// Input/output
////////////////////////////////////////////////////////////////

 /// Classes reading/writing freeling data structures into different input/output formats
 namespace io {
   
   /// Class input_conll loads a CoNLL-like column file.
   /// Order of columns can be customized in the config file provided to the constructor
   class input_conll  {
     
   public:   
     // default constructor. 
     input_conll();
     // constructor from config file
     input_conll(const std::wstring &fcfg);
     // destructor. 
     ~input_conll();
     
     void input_sentences(const std::wstring &lines, std::list<freeling::sentence> &ls) const;
     void input_document(const std::wstring &lines, freeling::document &doc) const;
   };

    
   /// Class output_conll writes sentenced to  a CoNLL-like column file.
   /// Order of columns can be customized in the config file provided to the constructor
    class output_conll  {

    public:   
      // empty constructor. 
      output_conll ();
      // constructor from cfg file
      output_conll (const std::wstring &cfgFile);
      // destructor. 
      ~output_conll ();

      /// print given sentences to sout in appropriate format
      void PrintResults (std::wostream &sout, const std::list<freeling::sentence> &ls) const;
      /// print given a document to sout in appropriate format
      void PrintResults(std::wostream &sout, const freeling::document &doc) const;

      // Print appropriate header for the ourput format (e.g. XML header or tag opening)
      void PrintHeader(std::wostream &sout) const;
      // print appropriate footer (e.g. close XML tags)
      void PrintFooter(std::wostream &sout) const; 

      // Print sentences/document to a string
      std::wstring PrintResults (const std::list<freeling::sentence> &ls) const;
      std::wstring PrintResults (const freeling::document &doc) const;
   };
  

   /// Class input_freeling loads a basic freeling column format (with one or more analysis per word)
    class input_freeling {      
    public:   
      // constructor. 
      input_freeling ();
      // destructor. 
      ~input_freeling ();
      
      void input_sentences(const std::wstring &lines, std::list<freeling::sentence> &ls) const;
    };

    /// Class output_freeling prints a document/sentece in classical freeling demo format

    class output_freeling {
    public:   
      // constructor. 
      output_freeling ();
      output_freeling(const std::wstring &cfgFile);
      ~output_freeling ();

      void PrintTree (std::wostream &sout, freeling::parse_tree::const_iterator n, int depth) const;
      void PrintDepTree (std::wostream &sout, freeling::dep_tree::const_iterator n, int depth) const;
      void PrintPredArgs (std::wostream &sout, const freeling::sentence &s) const;
      void PrintWord (std::wostream &sout, const freeling::word &w, bool only_sel=true, bool probs=true) const;
      void PrintCorefs(std::wostream &sout, const freeling::document &doc) const;
      void PrintSemgraph(std::wostream &sout, const freeling::document &doc) const;

      // print given sentences to sout in appropriate format
      void PrintResults (std::wostream &sout, const std::list<freeling::sentence> &ls) const;
      // print given a document to sout in appropriate format
      void PrintResults(std::wostream &sout, const freeling::document &doc) const;
      // Print sentences/document to a string
      std::wstring PrintResults (const std::list<freeling::sentence> &ls) const;
      std::wstring PrintResults (const freeling::document &doc) const;

      // activate/deactivate printing levels
      void output_senses(bool);
      void output_all_senses(bool);
      void output_phonetics(bool);
      void output_dep_tree(bool);
      void output_corefs(bool);  
      void output_semgraph(bool);
    };


    /// Class output_freeling prints a document/sentece in a json structure

    class output_json {

    public:   
      // constructor. 
      output_json ();
      output_json (const std::wstring &cfgFile);
      // destructor. 
      ~output_json ();

      // print given sentences to sout in appropriate format
      void PrintResults (std::wostream &sout, const std::list<freeling::sentence> &ls) const;
      // print given a document to sout in appropriate format
      void PrintResults(std::wostream &sout, const freeling::document &doc) const;
      // Print sentences/document to a string
      std::wstring PrintResults (const std::list<freeling::sentence> &ls) const;
      std::wstring PrintResults (const freeling::document &doc) const;
    };


    /// Class output_naf prints a document/sentece in the XML layered NAF format.

    class output_naf {

    public:   
      // constructor. 
      output_naf ();
      output_naf (const std::wstring &cfgFile);
      // destructor. 
      ~output_naf ();

      // print given sentences to sout in appropriate format
      void PrintResults (std::wostream &sout, const std::list<freeling::sentence> &ls) const;
      // print given a document to sout in appropriate format
      void PrintResults(std::wostream &sout, const freeling::document &doc) const;
      // Print sentences/document to a string
      std::wstring PrintResults (const std::list<freeling::sentence> &ls) const;
      std::wstring PrintResults (const freeling::document &doc) const;

      // print NAF header
      void PrintHeader(std::wostream &sout) const;
      // print NAF footer
      void PrintFooter(std::wostream &sout) const; 

      // activate/deactivate layer for next printings
      void ActivateLayer(const std::wstring &ly, bool b);

    };

    /// Class output_train prints sentences in a column format suitable for PoS-tagger training scripts

    class output_train {

    public:   
      // constructor. 
      output_train ();
      ~output_train ();

      // print given sentences to sout in appropriate format
      void PrintResults (std::wostream &sout, const std::list<freeling::sentence> &ls) const;
      // print given a document to sout in appropriate format
      void PrintResults(std::wostream &sout, const freeling::document &doc) const;
      // Print sentences/document to a string
      std::wstring PrintResults (const std::list<freeling::sentence> &ls) const;
      std::wstring PrintResults (const freeling::document &doc) const;

    };


    /// Class output_xml produces freeling XML format, more compact than NAF

    class output_xml {

    public:   
      // constructor. 
      output_xml ();
      output_xml (const std::wstring &cfgFile);
      // destructor. 
      ~output_xml ();

      // print XML file header
      void PrintHeader(std::wostream &sout) const; 
      // print XML file footer
      void PrintFooter(std::wostream &sout) const; 
      // print given sentences to sout in appropriate format
      void PrintResults (std::wostream &sout, const std::list<freeling::sentence> &ls) const;
      // print given a document to sout in appropriate format
      void PrintResults(std::wostream &sout, const freeling::document &doc) const;
      // Print sentences/document to a string
      std::wstring PrintResults (const std::list<freeling::sentence> &ls) const;
      std::wstring PrintResults (const freeling::document &doc) const;
    };
 
 }
}

 
