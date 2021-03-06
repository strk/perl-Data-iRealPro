#! perl

# Dummy for the packager, to get output backends and other
# conditionally required modules included.

# Backends.
use Data::iRealPro::Input;
use Data::iRealPro::Output;
use Data::iRealPro::Input::Text;
use Data::iRealPro::Output::Base;
use Data::iRealPro::Output::HTML;
use Data::iRealPro::Output::Imager;
use Data::iRealPro::Output::JSON;
use Data::iRealPro::Output::Text;

# Conditional requires for D::i::Imager.
use PDF::API2;
use Imager;

# Most TTF table data is required conditionally.
use Font::TTF::AATKern;
use Font::TTF::AATutils;
use Font::TTF::Anchor;
use Font::TTF::Bsln;
use Font::TTF::Cmap;
use Font::TTF::Coverage;
use Font::TTF::Cvt_;
use Font::TTF::DSIG;
use Font::TTF::Delta;
use Font::TTF::Dumper;
use Font::TTF::EBDT;
use Font::TTF::EBLC;
use Font::TTF::Fdsc;
use Font::TTF::Feat;
use Font::TTF::Features/Cvar;
use Font::TTF::Features/Size;
use Font::TTF::Features/Sset;
use Font::TTF::Fmtx;
use Font::TTF::Font;
use Font::TTF::Fpgm;
use Font::TTF::GDEF;
use Font::TTF::GPOS;
use Font::TTF::GSUB;
use Font::TTF::Glat;
use Font::TTF::Gloc;
use Font::TTF::Glyf;
use Font::TTF::Glyph;
use Font::TTF::GrFeat;
use Font::TTF::Hdmx;
use Font::TTF::Head;
use Font::TTF::Hhea;
use Font::TTF::Hmtx;
use Font::TTF::Kern;
use Font::TTF::Kern/ClassArray;
use Font::TTF::Kern/CompactClassArray;
use Font::TTF::Kern/OrderedList;
use Font::TTF::Kern/StateTable;
use Font::TTF::Kern/Subtable;
use Font::TTF::LTSH;
use Font::TTF::Loca;
use Font::TTF::Maxp;
use Font::TTF::Mort;
use Font::TTF::Mort/Chain;
use Font::TTF::Mort/Contextual;
use Font::TTF::Mort/Insertion;
use Font::TTF::Mort/Ligature;
use Font::TTF::Mort/Noncontextual;
use Font::TTF::Mort/Rearrangement;
use Font::TTF::Mort/Subtable;
use Font::TTF::Name;
use Font::TTF::OS_2;
use Font::TTF::OTTags;
use Font::TTF::OldCmap;
use Font::TTF::OldMort;
use Font::TTF::PCLT;
use Font::TTF::PSNames;
use Font::TTF::Post;
use Font::TTF::Prep;
use Font::TTF::Prop;
use Font::TTF::Segarr;
use Font::TTF::Silf;
use Font::TTF::Sill;
use Font::TTF::Table;
use Font::TTF::Ttc;
use Font::TTF::Ttopen;
use Font::TTF::Useall;
use Font::TTF::Utils;
use Font::TTF::Vhea;
use Font::TTF::Vmtx;
use Font::TTF::Woff;
use Font::TTF::Woff/MetaData;
use Font::TTF::Woff/PrivateData;
use Font::TTF::XMLparse;

# Same for Imager.
use Imager::Expr::Assem;
use Imager::Preprocess;
use Imager::Transform;
use Imager::Matrix2d;
use Imager::Font;
use Imager::Fill;
use Imager::File::SGI;
use Imager::File::JPEG;
use Imager::File::GIF;
use Imager::File::ICO;
use Imager::File::CUR;
use Imager::File::PNG;
use Imager::File::TIFF;
use Imager::Filter::Mandelbrot;
use Imager::Filter::DynTest;
use Imager::Filter::Flines;
use Imager::Regops;
use Imager::Color;
use Imager::CountColor;
use Imager::ExtUtils;
use Imager::Expr;
use Imager::Font::T1;
use Imager::Font::Wrap;
use Imager::Font::FreeType2;
use Imager::Font::Type1;
use Imager::Font::Truetype;
use Imager::Font::Image;
use Imager::Font::FT2;
use Imager::Font::Test;
use Imager::Font::BBox;
use Imager::Color::Float;
use Imager::Color::Table;
use Imager::Probe;
use Imager::Fountain;

1;
